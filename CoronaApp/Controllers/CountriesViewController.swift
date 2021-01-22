//
//  CountriesViewController.swift
//  CoronaApp
//
//  Created by Igor Parnadziev on 11/7/20.
//

import UIKit
import Alamofire

class CountriesViewController: UIViewController {
    
    @IBOutlet weak var countryTableView: UITableView!
    var country = Regions()
    var countryPerContinent = [Regions]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
    }
}

extension CountriesViewController: UITableViewDataSource, UITableViewDelegate {

    func setupTable() {
        countryTableView.register(UINib(nibName: "CountryTableViewCell", bundle: nil), forCellReuseIdentifier: "countryCell")
        countryTableView.delegate = self
        countryTableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countryPerContinent.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell") as! CountryTableViewCell
        let displayedCell = countryPerContinent[indexPath.row]
        cell.countryLbl.text = displayedCell.country
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let displayedCountry = countryPerContinent[indexPath.row]
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "CountryViewController") as! CountryViewController
        controller.population = displayedCountry.population!
        controller.title = displayedCountry.country
        present(controller, animated: true, completion: nil)
        navigationController?.pushViewController(controller, animated: true)
    }
}
