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
    private let locationManager: CLLocationManager
    private let searchController = UISearchController()
    private let searchCompleter: MKLocalSearchCompleter = {
        let completer = MKLocalSearchCompleter()
        completer.region = MKCoordinateRegion(.world)
        completer.resultTypes = MKLocalSearchCompleter.ResultType([.address])
        return completer
    }()
    private var searchResults = [MKLocalSearchCompletion]()
    private var searchComplition: MKLocalSearchCompletion? = nil
    private  var sections: [Section] {
        Section.getSections(searchTerm: searchController.searchBar.text, isSearchResultsEmpty: searchResults.isEmpty)
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
    }
    
    private func setupSearchController() {
        searchController.searchBar.delegate = self
    }
    
    private func setupNavBar() {
        title = "Регион"
        navigationItem.searchController = searchController
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
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
    
    @objc private func didTapDoneButton() {
        if let completion = searchComplition {
            let request = MKLocalSearch.Request(completion: completion)
            let search = MKLocalSearch(request: request)
            search.start { [weak self] responce, error in
                guard let responce = responce,
                      let item = responce.mapItems.first,
                      let location = item.placemark.location else { return }
                self?.delegate?.didSelectRegion(with: location)
                self?.navigationController?.dismiss(animated: true)
            }
        } else {
            navigationController?.dismiss(animated: true)
        }
    }
    
    private func setupSearchCompleter() {
        searchCompleter.delegate = self
    }
    
    private func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse:
            //Do map stuff
            guard let location = locationManager.location else { return }
            delegate?.didSelectRegion(with: location)
            navigationController?.dismiss(animated: true)
            break
        case .denied, .restricted:
            //Show allert with turn on instruction
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .authorizedAlways:
            break
        // if new cases are gonna be added in the future
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
            case .searchResult: return  searchResults.count
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
            let searchResult = searchResults[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: LocationSearchCell.reuseIdentifier) as! LocationSearchCell
            cell.titleLabel.text = searchResult.title
            cell.infoLabel.text = searchResult.subtitle
            return cell
        }
    }
}

//MARK: - UITableViewDelegate

extension CitySearchTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch sections[indexPath.section] {
        case .location:
            checkLocationAuthorization()
        case .searchResult:
            let cell = tableView.cellForRow(at: indexPath) as! LocationSearchCell
            selectedCell = cell
            searchController.searchBar.resignFirstResponder()
            searchComplition = searchResults[indexPath.row]
        }
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

//MARK: - MKLocalSearchCompleterDelegate

extension CitySearchTableViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        selectedCell = nil
        if let text = searchController.searchBar.text,
           text.count > 2 {
            citySearchView.tableView.backgroundView?.isHidden = !searchResults.isEmpty
        }
        citySearchView.tableView.reloadData()
    }
}

//MARK: - MKLocalSearchCompleterDelegate

extension CitySearchTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCompleter.queryFragment = searchText
        if searchText.isEmpty {
            searchResults = []
            selectedCell = nil
            citySearchView.tableView.reloadData()
        }
        if searchText.count < 2 {
            citySearchView.tableView.backgroundView?.isHidden = true
        }
    }
}
