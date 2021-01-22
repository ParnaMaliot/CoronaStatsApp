//
//  CountryViewController.swift
//  CoronaApp
//
//  Created by Igor Parnadziev on 11/9/20.
//

import UIKit

class CountryViewController: UIViewController {

    @IBOutlet weak var populationLbl: UILabel!
    
    var population = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "test"
        populationLbl.text = "\(population)"
        }

        
    }
