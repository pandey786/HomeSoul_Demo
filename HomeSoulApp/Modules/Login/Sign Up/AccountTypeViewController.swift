//
//  AccountTypeViewController.swift
//  HomeSoulApp
//
//  Created by Durgesh Pandey on 11/06/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import UIKit
import LTHRadioButton

class AccountTypeViewController: UIViewController {
    
    @IBOutlet weak var radioButtonFirst: LTHRadioButton!
    @IBOutlet weak var radioButtonSecond: LTHRadioButton!
    
    var isDistributer = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set Up Radio Button
        self.setUpRadioButtonsUI()
        self.setUpRadioButtonsState()
        
    }
    
    private func setUpRadioButtonsUI() {
        self.radioButtonFirst.selectedColor = UIColor.orange
        self.radioButtonFirst.deselectedColor = UIColor.orange
        self.radioButtonSecond.selectedColor = UIColor.orange
        self.radioButtonSecond.deselectedColor = UIColor.orange
        
        //Radio Button Actions
        self.radioButtonFirst.onSelect {
            self.isDistributer = true
            self.setUpRadioButtonsState()
        }
        
        self.radioButtonSecond.onSelect {
            self.isDistributer = false
            self.setUpRadioButtonsState()
        }
    }
    
    private func setUpRadioButtonsState() {
        if self.isDistributer {
            self.radioButtonFirst.select(animated: true)
            self.radioButtonSecond.deselect(animated: true)
        } else {
            self.radioButtonFirst.deselect(animated: true)
            self.radioButtonSecond.select(animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonNextTapped(_ sender: Any) {
        
        self.performSegue(withIdentifier: "UserDetailsViewController", sender: nil)
    }
    
}
