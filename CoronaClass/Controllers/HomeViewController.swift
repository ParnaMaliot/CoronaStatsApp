//
//  HomeViewController.swift
//  CoronaClass
//
//  Created by Igor Parnadjiev on 7.4.21.
//

import UIKit
import SnapKit
import JGProgressHUD

class HomeViewController: UIViewController, DisplayHudProtocol {
  
    var hud: JGProgressHUD?
    

    @IBOutlet weak var navigationHolderView: UIView!
    @IBOutlet weak var globalHolderView: UIView!
    @IBOutlet weak var confirmed: UILabel!
    @IBOutlet weak var deaths: UILabel!
    @IBOutlet weak var recovered: UILabel!
    @IBOutlet weak var buttonRetry: UIButton!
    @IBOutlet weak var lblConfirmedInfo: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavigationView()
        setupGlobalHolder()
        getGlobalData()
        collectionView.dataSource = self
        if let layout = collectionView.collectionViewLayout as? UICollectionViewLayout {
            
        }
        fetchCountries()
    }
    
    
    private func addNavigationView() {
        let navigationView = NavigationView(state: .onlyTitle, delegate: nil, title: "Dashboard")
        
        navigationHolderView.addSubview(navigationView)
        
        navigationView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupGlobalHolder() {
        globalHolderView.layer.cornerRadius = 8
        globalHolderView.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        globalHolderView.layer.shadowOpacity = 1.0
        globalHolderView.layer.shadowRadius = 10
        globalHolderView.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    private func getGlobalData() {
        displayHud(true)
        APIManager.shared.getGlobalInfo { [weak self] result in
            guard let self = self else {return}
            self.displayHud(false)
            switch result {
            case .failure(let error):
                self.buttonRetry.isHidden = false
                print(error.localizedDescription)
            case .success(let global):
                self.buttonRetry.isHidden = true
                self.setGlobalData(global: global)
            }
        }
    }
    private var selectedCountries = [Country]()
    
    private func fetchCountries() {
        displayHud(true)
        APIManager.shared.getAllCountries { [weak self] result in
            self?.displayHud(false)
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let countries):
                self?.selectedCountries = countries.filter {$0.isSelected}
                self?.collectionView.reloadData()
            }
        }
    }

    
    private func setGlobalData(global: Global) {
        deaths.text = global.deaths.getFormattedNumber()
        recovered.text = (global.recovered).getFormattedNumber()
        confirmed.text = (global.confirmed).getFormattedNumber()
        setFormattedLastUpdate()
    }
    
    private func setFormattedLastUpdate() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy, h:mm a"
        let formattedDate = dateFormatter.string(from: date)
        let updated = "Last updated on " + formattedDate
        let text = "Confirmed cases\n" + updated
        
        let attributed = NSMutableAttributedString(string: text)
        attributed.addAttributes([.font: UIFont.systemFont(ofSize: 16, weight: .bold), .foregroundColor: UIColor(hex: "3C3C3C")], range: (text as NSString).range(of: text))
        attributed.addAttributes([.font: UIFont.systemFont(ofSize: 14, weight: .regular), .foregroundColor: UIColor(hex: "707070")], range: (text as NSString).range(of: updated))
        lblConfirmedInfo.attributedText = attributed
    }
    
    @IBOutlet weak var addCountry: UIButton!
    
    @IBAction func btnAddCountry(_ sender: UIButton) {
        performSegue(withIdentifier: "countriesSegue", sender: nil)
    }
    
    @IBAction func btnRetry(_ sender: UIButton) {
        getGlobalData()
    }
    
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedCountries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CountryCell", for: indexPath) as! CountryCollectionViewCell
        let country = selectedCountries[indexPath.row]
        cell.lblCountryName.text = country.name
        cell.lblCasesNumber.text = "0"
        cell.setupCell()
        return cell
    }
}

