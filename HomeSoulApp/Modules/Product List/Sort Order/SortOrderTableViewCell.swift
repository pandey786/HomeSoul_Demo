//
//  SortOrderTableViewCell.swift
//  HomeSoulApp
//
//  Created by Durgesh Pandey on 16/04/18.
//  Copyright © 2018 HomeSoul. All rights reserved.
//

import UIKit

class SortOrderTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var viewUnderLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
