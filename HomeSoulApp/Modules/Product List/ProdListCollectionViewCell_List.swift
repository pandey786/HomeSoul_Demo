//
//  ProdListCollectionViewCell_List.swift
//  HomeSoulApp
//
//  Created by Durgesh Pandey on 13/04/18.
//  Copyright © 2018 HomeSoul. All rights reserved.
//

import UIKit

class ProdListCollectionViewCell_List: UICollectionViewCell {

    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var viewAddToCart: UIView!
    @IBOutlet weak var labelProdTitle: UILabel!
    @IBOutlet weak var labelProdPrice: UILabel!
    @IBOutlet weak var buttonAddToCart: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
