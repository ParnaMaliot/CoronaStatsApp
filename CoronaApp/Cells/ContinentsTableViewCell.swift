//
//  ContinentsTableViewCell.swift
//  CoronaApp
//
//  Created by Igor Parnadjiev on 10/29/20.
//

import UIKit

class ContinentsTableViewCell: UITableViewCell {

    @IBOutlet weak var continentsCell: UILabel!
    
//    func setupCell(text: Regions) {
//        self.continentsCell.text = text.continent
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
