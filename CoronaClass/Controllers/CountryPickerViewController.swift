//
//  CountryPickerViewController.swift
//  CoronaClass
//
//  Created by Igor Parnadjiev on 7.4.21.
//

import UIKit
import JGProgressHUD

protocol ReloadDataDelegate: AnyObject {
    func reloadCountriesData()
}

class CountryPickerViewController: UIViewController, DisplayHudProtocol, Alertable {
    
    
    
    @IBOutlet weak var navigationHolderView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmenControl: UISegmentedControl!
    @IBOutlet weak var searchHolderView: UIView!
    
    private var countries = [Country]()
    
    weak var delegate: ReloadDataDelegate?
    
    var hud: JGProgressHUD?
    
    private var searchController = UISearchController(searchResultsController: nil)
    
    var countriesDataSource: [Country] {
        if segmenControl.selectedSegmentIndex == 0 {
            guard let searchText = searchController.searchBar.text else {
               return  countries
            }
            return countries.filter {$0.name.lowercased().hasPrefix(searchText.lowercased())}
        } else {
            guard let searchText = searchController.searchBar.text else {
                return  countries.filter{$0.isSelected}
            }
            return countries.filter {$0.isSelected && $0.name.lowercased().hasPrefix(searchText.lowercased())}
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavigationView()
        setupTableView()
        fetchCountries()
        configureSegmentControl()
        setupSearchController()
    }
    
    private func addNavigationView() {
        let navigationView = NavigationView(state: .backAndTitle, delegate: self, title: "Add Country")
        navigationHolderView.addSubview(navigationView)
        navigationView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.rowHeight = 80
        tableView.separatorColor = UIColor(hex: "EDEDED")
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        tableView.keyboardDismissMode = .onDrag
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: CountryTableViewCell.reuseIdentifier)
    }
    
    private func fetchCountries() {
        displayHud(true)
        APIManager.shared.getAllCountries { [weak self] result in
            self?.displayHud(false)
            switch result {
            case .failure(let error):
                self?.showErrorAlert(error)
            case .success(let countries):
                self?.countries = countries.sorted(by: {$0.name < $1.name})
                self?.tableView.reloadData()
            }
        }
    }
    
    private func configureSegmentControl() {
        segmenControl.setBackgroundImage(nil, for: .normal, barMetrics: .compact)
        
        segmenControl.setTitleTextAttributes([
                                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular), NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        segmenControl.setTitleTextAttributes([
                                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular), NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
    }
    
    @IBAction func onSegmentChanged(_ segmentControl: UISegmentedControl) {
        tableView.reloadData()
    }
    
    private func setupSearchController() {
        searchHolderView.layer.cornerRadius = 25
        searchHolderView.layer.masksToBounds = true
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search Countries"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchHolderView.addSubview(searchController.searchBar)
        searchController.extendedLayoutIncludesOpaqueBars = true
        searchController.automaticallyShowsCancelButton = false
        searchController.definesPresentationContext = true
        searchController.extendedLayoutIncludesOpaqueBars = true
        searchHolderView.clipsToBounds = true
    }
}

extension CountryPickerViewController: NavigationViewDelegate {
    func didTapBack() {
        searchController.isActive = false
        navigationController?.popViewController(animated: true)
    }
}

extension CountryPickerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countriesDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.reuseIdentifier) as! CountryTableViewCell
        if indexPath.row >= countriesDataSource.count {
            return cell
        }
        let country = countriesDataSource[indexPath.row]
        cell.setupCellData(country: country)
        cell.delegate = self
        return cell
    }
}
extension CountryPickerViewController: CountrySelectionDelegate {
    func didChangeValueOn(country: Country) {
        delegate?.reloadCountriesData()
        guard let index = countriesDataSource.firstIndex(where: {$0.isoCode == country.isoCode}) else {
            return
        }
        tableView.reloadRows(at: [IndexPath(item: index, section: 0)], with: .none)
    }
}

extension CountryPickerViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        tableView.reloadData()
    }
}
