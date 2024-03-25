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

final class CitySearchViewController: UIViewController {
    
    private lazy var citySearchView = CitySearchView()
    private var searchCache = SearchCache()
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
        loadSearchResults()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //to prevent retain cycle
        searchController.dismiss(animated: false)
    }
    
    private func setupSearchCompleter() {
        searchCompleter.delegate = self
    }
    
    private func loadSearchResults() {
        searchCache.loadAllSearchPlaces()
        cachedSearchResults = searchCache.searchResults
    }
    
    private func setupSearchController() {
        searchController.searchBar.delegate = self
    }
    
    private func setupNavBar() {
        title = Constants.strings.citySearchTitle
        navigationItem.searchController = searchController
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Constants.images.close, style: .plain, target: self, action: #selector(didTapCloseButton))
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
            searchCache.addAndSaveNewResult(SearchResult(title: completion.title, subtitle: completion.subtitle))
            let request = MKLocalSearch.Request(completion: completion)
            let search = MKLocalSearch(request: request)
            handleSearch(search)
        } else if let selectedSearchResult = selectedSearchResult {
            let searchRequest = MKLocalSearch.Request()
            searchRequest.naturalLanguageQuery = selectedSearchResult.description
            let search = MKLocalSearch(request: searchRequest)
            handleSearch(search)
        } else {
            navigationController?.dismiss(animated: true)
        }
    }
    
    private func handleSearch(_ search: MKLocalSearch) {
        Task {
            let responce = try await search.start()
            guard let item = responce.mapItems.first,
                  let location = item.placemark.location else { return }
            delegate?.didSelectRegion(with: location)
        }
        navigationController?.dismiss(animated: true)
    }
    
    private func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            navigationController?.dismiss(animated: true) {
                guard let location = self.locationManager.location else { return }
                self.delegate?.didSelectRegion(with: location)
            }
        case .denied:
            presentConfirmAlert(title: Constants.strings.error, message: Constants.strings.deniedMessage)
        case .restricted:
            presentConfirmAlert(title: Constants.strings.error, message: Constants.strings.restrictedMessage)
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            fatalError("add new cases")
        }
    }
}

//MARK: - UITableViewDataSource

extension CitySearchViewController: UITableViewDataSource {
  
    private func numberOfRows(for section: Section) -> Int {
        switch section {
        case .location: return Constants.layout.numberOfRowsLocationSection
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
                cell.configureWithSearchResult(searchResult)
            } else {
                let searchCompletion = searchCompletions[indexPath.row]
                cell.configureWithCompletion(searchCompletion)
            }
            return cell
        }
    }
}

//MARK: - UITableViewDelegate

extension CitySearchViewController: UITableViewDelegate {
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
         return Constants.layout.heightForTableViewRow
    }
}

//MARK: - MKLocalSearchCompleterDelegate

extension CitySearchViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchCompletions = completer.results
        selectedCell = nil
        if let text = searchController.searchBar.text,
           text.count >= Constants.numbers.maxTextCount {
            citySearchView.tableView.backgroundView?.isHidden = !searchCompletions.isEmpty
        }
        citySearchView.tableView.reloadData()
    }
}

//MARK: - MKLocalSearchCompleterDelegate

extension CitySearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCompleter.cancel()
        searchCompleter.queryFragment = searchText
        if searchText.isEmpty {
            searchCompletions = []
            selectedCell = nil
            citySearchView.tableView.reloadData()
        }
        if searchText.count < Constants.numbers.maxSearchTextCount {
            citySearchView.tableView.backgroundView?.isHidden = true
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = Constants.strings.empty
        searchBar.resignFirstResponder()
        citySearchView.tableView.reloadData()
    }
}
