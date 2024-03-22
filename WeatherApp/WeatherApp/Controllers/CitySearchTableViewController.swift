//
//  CitySearchTableViewController.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 21.03.2024.
//

import UIKit
import MapKit

protocol CitySearchTableViewControllerDelegate: AnyObject {
    func didSelectRegion(with location: CLLocation )
}

class CitySearchTableViewController: UIViewController {
    
    private lazy var citySearchView = CitySearchView()
    private var cachedSearchResults: [SearchResult] = []
    private var selectedSearchResult: SearchResult? = nil
    private let locationManager: CLLocationManager
    private let searchController = UISearchController()
    private let searchCompleter: MKLocalSearchCompleter = {
        let completer = MKLocalSearchCompleter()
        completer.region = MKCoordinateRegion(.world)
        completer.resultTypes = MKLocalSearchCompleter.ResultType([.address])
        return completer
    }()
    private var searchCompletions = [MKLocalSearchCompletion]()
    private var selectedSearchCompletion: MKLocalSearchCompletion? = nil
    private var sections: [Section] {
        Section.getSections(searchTerm: searchController.searchBar.text, isSearchResultsEmpty: searchCompletions.isEmpty)
    }
    private var selectedCell: LocationSearchCell? = nil {
        didSet {
            if oldValue != selectedCell {
                oldValue?.toNormalState()
            }
        }
        willSet {
            if newValue != selectedCell {
                newValue?.toSelectedState()
            }
        }
    }
    
    weak var delegate: CitySearchTableViewControllerDelegate?
    
    init(locationManager: CLLocationManager) {
        self.locationManager = locationManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = citySearchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        setupTableView()
        setupNavBar()
        setupDoneButton()
        setupSearchCompleter()
        SearchCache.shared.loadAllSearchPlaces()
        cachedSearchResults = SearchCache.shared.searchResults
    }
    
    private func setupSearchController() {
        searchController.searchBar.delegate = self
    }
    
    private func setupNavBar() {
        title = "Регион"
        navigationItem.searchController = searchController
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "close"), style: .plain, target: self, action: #selector(didTapCloseButton))
        navigationItem.rightBarButtonItem?.tintColor = .systemGray
    }
    
    private func setupTableView() {
        citySearchView.tableView.dataSource = self
        citySearchView.tableView.delegate = self
        citySearchView.tableView.backgroundColor = .systemBackground
        citySearchView.tableView.separatorStyle = .none
        citySearchView.tableView.register(LocationSearchCell.self, forCellReuseIdentifier: LocationSearchCell.reuseIdentifier)
        citySearchView.tableView.register(UserLocationCell.self, forCellReuseIdentifier: UserLocationCell.reuseIdentifier)
    }
    
    private func setupDoneButton() {
        citySearchView.doneButton.addTarget(self, action: #selector(didTapDoneButton), for: .touchUpInside)
    }
    
    @objc private func didTapCloseButton() {
        navigationController?.dismiss(animated: true)
    }
    
    @objc private func didTapDoneButton() {
        if let completion = selectedSearchCompletion {
            SearchCache.shared.addAndSaveNewResult(SearchResult(title: completion.title, subtitle: completion.subtitle))
            let request = MKLocalSearch.Request(completion: completion)
            let search = MKLocalSearch(request: request)
            Task {
                let responce = try await search.start()
                guard let item = responce.mapItems.first,
                      let location = item.placemark.location else { return }
                delegate?.didSelectRegion(with: location)
            }
            navigationController?.dismiss(animated: true)
        } else if let selectedSearchResult = selectedSearchResult {
            let searchRequest = MKLocalSearch.Request()
            searchRequest.naturalLanguageQuery = selectedSearchResult.description
            let search = MKLocalSearch(request: searchRequest)
            Task {
                let responce = try await search.start()
                guard let item = responce.mapItems.first,
                      let location = item.placemark.location else { return }
                delegate?.didSelectRegion(with: location)
            }
            navigationController?.dismiss(animated: true)
        } else {
            navigationController?.dismiss(animated: true)
        }
    }
    
    private func setupSearchCompleter() {
        searchCompleter.delegate = self
    }
    
    private func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            navigationController?.dismiss(animated: true) {
                guard let location = self.locationManager.location else { return }
                self.delegate?.didSelectRegion(with: location)
            }
        case .denied:
            presentConfirmAlert(title: "Ошибка", message: "Доступ к местоположению запрещен. Пожалуйста разрешите это в настройках")
        case .restricted:
            presentConfirmAlert(title: "Ошибка", message: "Доступ к местоположению ограничен родительским контролем")
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            fatalError("add new cases")
        }
    }
}

//MARK: - UITableViewDataSource

extension CitySearchTableViewController: UITableViewDataSource {
    private enum Section: String, CaseIterable {
        case location, searchResult
        
        static func getSections(searchTerm: String?, isSearchResultsEmpty: Bool) -> [Section] {
            if let searchTerm = searchTerm,
               isSearchResultsEmpty,
               searchTerm.count > 1 {
                return []
            } else {
                return allCases
            }
        }
    }
    
    private func numberOfRows(for section: Section) -> Int {
        switch section {
            case .location: return 1
            case .searchResult:
            if searchCompletions.isEmpty {
                return cachedSearchResults.count
            } else {
                return searchCompletions.count
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows(for: sections[section])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case .location:
            let cell = tableView.dequeueReusableCell(withIdentifier: UserLocationCell.reuseIdentifier) as! UserLocationCell
            return cell
        case .searchResult:
            let cell = tableView.dequeueReusableCell(withIdentifier: LocationSearchCell.reuseIdentifier) as! LocationSearchCell
            if searchCompletions.isEmpty {
                let searchResult = cachedSearchResults[indexPath.row]
                cell.titleLabel.text = searchResult.title
                cell.infoLabel.text = searchResult.subtitle
            } else {
                let searchResult = searchCompletions[indexPath.row]
                cell.titleLabel.text = searchResult.title
                cell.infoLabel.text = searchResult.subtitle
            }
            return cell
        }
    }
}

//MARK: - UITableViewDelegate

extension CitySearchTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch sections[indexPath.section] {
        case .location:
            let cell = tableView.cellForRow(at: indexPath) as! UserLocationCell
            cell.animateSelectedBackgroundView()
            checkLocationAuthorization()
        case .searchResult:
            let cell = tableView.cellForRow(at: indexPath) as! LocationSearchCell
            cell.animateSelectedBackgroundView()
            selectedCell = cell
            searchController.searchBar.resignFirstResponder()
            if searchCompletions.isEmpty {
                selectedSearchCompletion = nil
                selectedSearchResult = cachedSearchResults[indexPath.row]
            } else {
                selectedSearchResult = nil
                selectedSearchCompletion = searchCompletions[indexPath.row]
            }
        }
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

//MARK: - MKLocalSearchCompleterDelegate

extension CitySearchTableViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchCompletions = completer.results
        selectedCell = nil
        if let text = searchController.searchBar.text,
           text.count > 2 {
            citySearchView.tableView.backgroundView?.isHidden = !searchCompletions.isEmpty
        }
        citySearchView.tableView.reloadData()
    }
}

//MARK: - MKLocalSearchCompleterDelegate

extension CitySearchTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCompleter.queryFragment = searchText
        if searchText.isEmpty {
            searchCompletions = []
            selectedCell = nil
            citySearchView.tableView.reloadData()
        }
        if searchText.count < 2 {
            citySearchView.tableView.backgroundView?.isHidden = true
        }
    }
}
