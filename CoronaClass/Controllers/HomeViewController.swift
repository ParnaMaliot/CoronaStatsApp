//
//  HomeViewController.swift
//  CoronaClass
//
//  Created by Igor Parnadjiev on 7.4.21.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {

    @IBOutlet weak var navigationHolderView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavigationView()
    }
    
    
    private func addNavigationView() {
        let navigationView = NavigationView(state: .onlyTitle, delegate: nil, title: "Dashboard")
        
        navigationHolderView.addSubview(navigationView)
        
        navigationView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    @IBOutlet weak var addCountry: UIButton!
    
    @IBAction func btnAddCountry(_ sender: UIButton) {
        performSegue(withIdentifier: "countriesSegue", sender: nil)
    }
    
}

