//
//  CountryCollectionViewCell.swift
//  CoronaClass
//
//  Created by Igor Parnadjiev on 13.4.21.
//

import UIKit

class CountryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var lblCountryName: UILabel!
    @IBOutlet weak var lblCasesNumber: UILabel!
    
    func setupCell() {
        shadowView.layer.cornerRadius = 8
        shadowView.layer.shadowColor = UIColor.black.withAlphaComponent(0.05).cgColor
        shadowView.layer.shadowOpacity = 1.0
        shadowView.layer.shadowRadius = 8
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
    }
}
