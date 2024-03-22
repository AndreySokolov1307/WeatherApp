//
//  ViewController.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 19.03.2024.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    private lazy var weatherView = WeatherView()
    private lazy var networkService = NetworkService()
    private let navBarTitleView = NavBarTitleView()
    private let locationManager = CLLocationManager()
    private var weatherTask: Task<Void, Never>? = nil
    private var sections: [CollectionViewSection] {
        CollectionViewSection.getSections(isLoading: isLoading)
    }
    private var isLoading = true
    private let userHaveSeenDeniedAlert = UserDefaults.standard.bool(forKey: "haveSeenDeniedAlert")
    private var weather: Weaher? {
        didSet {
            isLoading = false
            weatherView.collectionView.reloadData()
        }
    }
    
    override func loadView() {
        view = weatherView
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupCollectionView()
        checkLocationServices()
    }
    
    private func setupNavBar() {
        navigationItem.titleView = navBarTitleView
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapNavBarTitleView))
        navBarTitleView.addGestureRecognizer(tap)
    }
    
    @objc private func didTapNavBarTitleView() {
        let citySearchController = CitySearchTableViewController(locationManager: locationManager)
        citySearchController.delegate = self
        let nav = UINavigationController(rootViewController: citySearchController)
        present(nav, animated: true)
    }
    
    private func setupCollectionView() {
        weatherView.collectionView.dataSource = self
        weatherView.collectionView.delegate = self
        weatherView.collectionView.register(DailyCell.self, forCellWithReuseIdentifier: DailyCell.reuseIdentifier)
        weatherView.collectionView.register(DetailCell.self, forCellWithReuseIdentifier: DetailCell.reuseIdentifier)
        weatherView.collectionView.register(MainCell.self, forCellWithReuseIdentifier: MainCell.reuseIdentifier)
        weatherView.collectionView.register(LoadingDetailCell.self, forCellWithReuseIdentifier: LoadingDetailCell.reuseIdentifier)
        weatherView.collectionView.register(LoadingMainCell.self, forCellWithReuseIdentifier: LoadingMainCell.self.reuseIdentifier)
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
                print(error)
            }
            weatherTask = nil
        }
    }
    
    private func updateUIWithMoscowLocation() {
        weatherTask?.cancel()
        weatherTask = Task {
            do {
                let location = CLLocation(latitude: 55.7512, longitude: 37.6156)
                weather = try await networkService.fetchWeather(latitude: 55.7512, longitude:  37.6156)
                try await navBarTitleView.configure(with: location, weather: weather)
            } catch let error as NSError where error.domain == NSURLErrorDomain && error.code == NSURLErrorCancelled {
                // ignore cancellation errors
            } catch {
                print(error)
            }
            weatherTask = nil
        }
    }
    
    private func checkLocationServices() {
        Task.detached {
            if CLLocationManager.locationServicesEnabled() {
                await self.setupLocationManager()
                await self.checkLocationAuthorization()
            } else {
                //show allert that user have to turn this on
            }
        }
    }
    
    private func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            guard let location = locationManager.location else { return }
            weatherTask = Task {
                updateUI(with: location)
            }
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
            updateUIWithMoscowLocation()
        } else {
            updateUIWithMoscowLocation()
            if status == .restricted {
                presentConfirmAlert(title: "Ошибка", message: "Доступ к местоположению ограничен родительским контролем")
            } else {
                presentConfirmAlert(title: "Ошибка", message: "Доступ к местоположению запрещен. Пожалуйста разрешите это в настройках")
            }
            UserDefaults.standard.set(true, forKey: "haveSeenDeniedAlert")
        }
    }
}

//MARK: - UICollectionViewDataSource

extension WeatherViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    private func numberOfItems(in section: CollectionViewSection) -> Int {
        switch section {
        case .main: return 1
        case .detail: return  1
        case .sevenDays:
            if let weather = weather {
                return weather.daily.dates.count
            } else {
                return 0
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
                cell.configure(with: weather!.current)
                return cell
            }
        case .detail:
            if isLoading {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoadingDetailCell.reuseIdentifier, for: indexPath) as! LoadingDetailCell
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCell.reuseIdentifier, for: indexPath) as! DetailCell
                cell.configure(with: weather!)
                return cell
            }
        case .sevenDays:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyCell.reuseIdentifier, for: indexPath) as! DailyCell
            let singleDay = SingleDay(date: (weather?.daily.dates[indexPath.row])!,
                                      weatherCode: (weather?.daily.weatherCodes[indexPath.row])!,
                                      temperaturesMax: (weather?.daily.temperaturesMax[indexPath.row])!,
                                      temperaturesMin: (weather?.daily.temperaturesMin[indexPath.row])!)
            cell.configure(with: singleDay)
            return cell
        }
    }
}

//MARK: - UICollectionViewDelegate

extension WeatherViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionViewHeader.reuseIdentifier, for: indexPath) as! CollectionViewHeader
        switch CollectionViewSection.allCases[indexPath.section] {
        case .detail:
            header.label.text = "Сейчас"
            header.label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        case .sevenDays:
            header.label.text = "Прогноз на 7 дней"
            header.label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        case .main:
            break
        }
        return header
    }
}

//MARK: - CitySearchTableViewControllerDelegate

extension WeatherViewController: CitySearchTableViewControllerDelegate {
    func didSelectRegion(with location: CLLocation) {
        weatherTask?.cancel()
        weatherTask = Task {
            do {
                weather = try await networkService.fetchWeather(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                try await navBarTitleView.configure(with: location, weather: weather)
            } catch let error as NSError where error.domain == NSURLErrorDomain && error.code == NSURLErrorCancelled {
                // ignore cancellation errors
            } catch {
                print(error)
            }
            weatherTask = nil
        }
    }
}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
