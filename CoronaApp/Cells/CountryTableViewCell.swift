//
//  CountryTableViewCell.swift
//  CoronaApp
//
//  Created by Igor Parnadziev on 11/7/20.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    @IBOutlet weak var countryLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
