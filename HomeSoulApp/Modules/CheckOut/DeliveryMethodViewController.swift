//
//  DeliveryMethodViewController.swift
//  HomeSoulApp
//
//  Created by Durgesh Pandey on 03/07/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import UIKit
import LTHRadioButton

class DeliveryMethodViewController: UIViewController {

    @IBOutlet weak var radioButtonFlatShipping: LTHRadioButton!
    @IBOutlet weak var radioButtonFreeShipping: LTHRadioButton!
    
    var isFlatShipping = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set Up Radio Button
        self.setUpRadioButtonsUI()
        self.setUpRadioButtonsState()
    }
    
    private func setUpRadioButtonsUI() {
        self.radioButtonFlatShipping.selectedColor = UIColor.orange
        self.radioButtonFlatShipping.deselectedColor = UIColor.orange
        self.radioButtonFreeShipping.selectedColor = UIColor.orange
        self.radioButtonFreeShipping.deselectedColor = UIColor.orange
        
        //Radio Button Actions
        self.radioButtonFlatShipping.onSelect {
            self.isFlatShipping = true
            self.setUpRadioButtonsState()
        }
        
        self.radioButtonFreeShipping.onSelect {
            self.isFlatShipping = false
            self.setUpRadioButtonsState()
        }
    }
    
    private func setUpRadioButtonsState() {
        if self.isFlatShipping {
            self.radioButtonFlatShipping.select(animated: true)
            self.radioButtonFreeShipping.deselect(animated: true)
        } else {
            self.radioButtonFlatShipping.deselect(animated: true)
            self.radioButtonFreeShipping.select(animated: true)
        }
    }
    
    @IBAction func buttonContinueTapped(_ sender: Any) {
        
        self.performSegue(withIdentifier: "PaymentMethodViewController", sender: nil)
    }
}
