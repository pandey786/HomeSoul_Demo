//
//  FilterListTableViewCell_SecondLevel.swift
//  HomeSoulApp
//
//  Created by Durgesh Pandey on 16/04/18.
//  Copyright © 2018 HomeSoul. All rights reserved.
//

import UIKit

class FilterListTableViewCell_SecondLevel: UITableViewCell {

    @IBOutlet weak var imageViewCheckMark: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpData(treeViewNode: CITreeViewNode) {
        
        //Set text
        let filterListItem = treeViewNode.item as! FilterListTreeDataModel
        self.labelTitle.text = filterListItem.name
        
        //set check mark
        self.imageViewCheckMark.isHidden = !filterListItem.isSelected
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
