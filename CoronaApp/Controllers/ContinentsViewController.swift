//
//  ContinentsViewController.swift
//  CoronaApp
//
//  Created by Igor Parnadjiev on 10/29/20.
//

import UIKit
import Alamofire

class ContinentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var continentsTableView: UITableView!
    
    var continents = Continents()
    var filteredContinents = [String]()
    
    var varijablaZaPrezemanjeOdMain = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTable()
        
        APIManager.shared.showContinents { (continents, error) in
            if let continents = continents {
                self.continents = continents
                let compactSet = Set(continents.response.compactMap({$0.continent}))
                self.filteredContinents = Array(compactSet)
                self.continentsTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredContinents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "continentsCell") as! ContinentsTableViewCell
        let displayedCell = filteredContinents[indexPath.row]
        cell.continentsCell.text = displayedCell
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let continent = filteredContinents[indexPath.row]
        var countries = continents.response.filter({$0.continent == continent})

        if continent == "All" {
            countries = continents.response
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CountriesViewController") as! CountriesViewController
        controller.countryPerContinent = countries
        present(controller, animated: true, completion: nil)
        navigationController?.pushViewController(controller, animated: true)
    }
    

    
    func setupTable() {
        continentsTableView.register(UINib(nibName: "ContinentsTableViewCell", bundle: nil), forCellReuseIdentifier: "continentsCell")
        continentsTableView.delegate = self
        continentsTableView.dataSource = self
        
    }
    

    
}
