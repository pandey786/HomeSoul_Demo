//
//  FilterListTableViewCell_FirstLevel.swift
//  HomeSoulApp
//
//  Created by Durgesh Pandey on 16/04/18.
//  Copyright © 2018 HomeSoul. All rights reserved.
//

import UIKit

class FilterListTableViewCell_FirstLevel: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setUpData(treeViewNode: CITreeViewNode) {
    
       //Set Title Font
        self.labelTitle.font = treeViewNode.expand ? UIFont.systemFont(ofSize: 14.0, weight: .bold): UIFont.systemFont(ofSize: 14.0, weight: .light)
        
        //Set text
        let filterListItem = treeViewNode.item as! FilterListTreeDataModel
        var countStr = ""
        
        var selectedChildCount = 0
        for child in filterListItem.children {
            if child.isSelected {
                selectedChildCount += 1
            }
        }
        
        if selectedChildCount > 0 {
            countStr = String("(\(selectedChildCount))")
        }
        
        self.labelTitle.text = filterListItem.name + countStr
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
