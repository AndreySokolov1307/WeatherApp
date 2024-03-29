//
//  ViewController.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 19.03.2024.
//

import UIKit
import CoreLocation

final class WeatherViewController: UIViewController {
    
    private lazy var weatherView = WeatherView()
    private lazy var networkService = NetworkService()
    private let navBarTitleView = NavBarTitleView()
    private let locationManager = CLLocationManager()
    private var weatherTask: Task<Void, Never>? = nil
    private var sections: [Section] {
        Section.getSections(isLoading: isLoading)
    }
    private var isLoading = true
    private let userHaveSeenDeniedAlert = UserDefaults.standard.bool(forKey: Constants.strings.haveSeenDeniedAlertKey)
    private let twelveHoursFormatter: TwelveHoursWeatherFormatter? = nil
    private var twelveHoursData: TwelveHoursWeather? = nil
    private var weather: Weather? {
        didSet {
            isLoading = false
            setupTwelveHoursData()
            weatherView.collectionView.reloadData()
        }
    }
    
    override func loadView() {
        view = weatherView
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        addTargetToErrorViewButton()
        setupCollectionView()
        checkLocationServices()
    }
    
    private func setupTwelveHoursData() {
        if let weather = weather {
            let twelveHoursFormatter = TwelveHoursWeatherFormatter(currentTime: weather.current.time,
                                                                   hours: weather.hourly.time,
                                                                   temperatures: weather.hourly.temperature,
                                                                   weatherCodes: weather.hourly.weatherCode,
                                                                   isDay: weather.hourly.isDay)
            twelveHoursData = TwelveHoursWeather(hours: twelveHoursFormatter.hoursFormatted(),
                                                 temperatures: twelveHoursFormatter.temperaturesFormatted(),
                                                 weatherCodeImages: twelveHoursFormatter.weatherCodesImagesFormatted())
        }
    }
    
    private func setupNavBar() {
        navigationItem.titleView = navBarTitleView
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapNavBarTitleView))
        navBarTitleView.addGestureRecognizer(tap)
    }
    
    @objc private func didTapNavBarTitleView() {
        let citySearchController = CitySearchViewController(locationManager: locationManager)
        citySearchController.delegate = self
        let nav = UINavigationController(rootViewController: citySearchController)
        present(nav, animated: true)
    }
    
    private func setupCollectionView() {
        weatherView.collectionView.setCollectionViewLayout(createLayout(), animated: true)
        weatherView.collectionView.dataSource = self
        weatherView.collectionView.delegate = self
        weatherView.collectionView.register(DailyCell.self, forCellWithReuseIdentifier: DailyCell.reuseIdentifier)
        weatherView.collectionView.register(HourlyCell.self, forCellWithReuseIdentifier: HourlyCell.reuseIdentifier)
        weatherView.collectionView.register(DetailCell.self, forCellWithReuseIdentifier: DetailCell.reuseIdentifier)
        weatherView.collectionView.register(MainCell.self, forCellWithReuseIdentifier: MainCell.reuseIdentifier)
        weatherView.collectionView.register(LoadingMainCell.self, forCellWithReuseIdentifier: LoadingMainCell.self.reuseIdentifier)
        weatherView.collectionView.register(LoadingHourlyCell.self, forCellWithReuseIdentifier: LoadingHourlyCell.reuseIdentifier)
        weatherView.collectionView.register(CollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionViewHeader.reuseIdentifier)
    }
    
    private func setupLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
    }
    
    private func updateUI(with location: CLLocation) {
        weatherTask?.cancel()
        weatherTask = Task {
            do {
                weather = try await networkService.fetchWeather(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                try await navBarTitleView.configure(with: location, weather: weather)
            } catch let error as NSError where error.domain == NSURLErrorDomain && error.code == NSURLErrorCancelled {
                // ignore cancellation errors
            } catch {
                updateUIWithError()
            }
            weatherTask = nil
        }
    }
    
    private func updateUIWithError() {
        weatherView.errorView.isHidden = false
    }
    
    private func addTargetToErrorViewButton() {
        weatherView.errorView.tryAgainButton.addTarget(self, action: #selector(didTapTryAgainButton), for: .touchUpInside)
    }
    
    @objc private func didTapTryAgainButton() {
        weatherView.errorView.isHidden = true
        checkLocationAuthorization()
        
    }
    
    private func checkLocationServices() {
        Task.detached {
            if CLLocationManager.locationServicesEnabled() {
                await self.setupLocationManager()
                await self.checkLocationAuthorization()
            } else {
                await self.presentConfirmAlert(title: Constants.strings.error, message: Constants.strings.locationServicesDisabled)
            }
        }
    }
    
    private func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            guard let location = locationManager.location else { return }
            updateUI(with: location)
        case .denied:
            handleLackOfUserLocation(for: .denied)
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            handleLackOfUserLocation(for: .restricted)
        @unknown default:
            fatalError("add new cases")
        }
    }
    
    private func handleLackOfUserLocation(for status: CLAuthorizationStatus) {
        if userHaveSeenDeniedAlert {
            updateUI(with: Constants.location.moscowLocation)
        } else {
            updateUI(with: Constants.location.moscowLocation)
            if status == .restricted {
                presentConfirmAlert(title: Constants.strings.error, message: Constants.strings.restrictedMessage)
            } else {
                presentConfirmAlert(title: Constants.strings.error, message: Constants.strings.deniedMessage)
            }
            UserDefaults.standard.set(true, forKey: Constants.strings.haveSeenDeniedAlertKey)
        }
    }
}

//MARK: - UICollectionViewDataSource

extension WeatherViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    private func numberOfItems(in section: Section) -> Int {
        switch section {
        case .main: return Constants.layout.numberOfItemsMainSection
        case .hourly: return Constants.layout.numberOfItemsHourlySection
        case .detail: return Constants.layout.numberOfItemsDetailSection
        case .sevenDays:
            if let weather = weather {
                return weather.daily.dates.count
            } else {
                return Constants.layout.zeroItems
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems(in: sections[section])
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
        case .main:
            if isLoading {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoadingMainCell.reuseIdentifier, for: indexPath) as! LoadingMainCell
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCell.reuseIdentifier, for: indexPath) as! MainCell
                if let weather = weather {
                    cell.configure(with: weather.current)
                }
                return cell
            }
        case .hourly:
            if isLoading {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoadingHourlyCell.reuseIdentifier, for: indexPath)
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyCell.reuseIdentifier, for: indexPath) as! HourlyCell
                cell.configureWith(time: twelveHoursData?.hours[indexPath.row],
                                   image: twelveHoursData?.weatherCodeImages[indexPath.row],
                                   temperature: twelveHoursData?.temperatures[indexPath.row])
                return cell
            }
        case .detail:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCell.reuseIdentifier, for: indexPath) as! DetailCell
                if let weather = weather {
                    cell.configure(with: weather)
                }
                return cell
        case .sevenDays:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyCell.reuseIdentifier, for: indexPath) as! DailyCell
            if let weather = weather {
                let singleDay = SingleDay(date: (weather.daily.dates[indexPath.row]),
                                          weatherCode: (weather.daily.weatherCodes[indexPath.row]),
                                          temperaturesMax: (weather.daily.temperaturesMax[indexPath.row]),
                                          temperaturesMin: (weather.daily.temperaturesMin[indexPath.row]))
                cell.configure(with: singleDay)
            }
            return cell
        }
    }
}

//MARK: - UICollectionViewDelegate

extension WeatherViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionViewHeader.reuseIdentifier, for: indexPath) as! CollectionViewHeader
        switch Section.allCases[indexPath.section] {
        case .detail:
            header.label.text = Constants.strings.detailHeaderTitle
            header.label.font = Constants.fonts.detailHeader
        case .sevenDays:
            header.label.text = Constants.strings.sevenDaysHeaderTitle
            header.label.font = Constants.fonts.sevenDaysHeader
        case .main, .hourly:
            break
        }
        return header
    }
}

//MARK: - CitySearchTableViewControllerDelegate

extension WeatherViewController: CitySearchTableViewControllerDelegate {
    func didSelectRegion(with location: CLLocation) {
        updateUI(with: location)
    }
}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
