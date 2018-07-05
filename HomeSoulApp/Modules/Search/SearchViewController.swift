//
//  SearchViewController.swift
//  HomeSoulApp
//
//  Created by Durgesh Pandey on 02/07/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import UIKit
import EMAlertController

class SearchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presentAlertForComingSoon()
    }
    
    private func presentAlertForComingSoon() {
        let alertCtrl = EMAlertController.init(title: "Coming Soon...", message: "Hi,\n Thanks For your Patience.\n We are still in Development Phase, You will be able to enjoy complete features of HomeSoul Soon.")
        let okButton = EMAlertAction(title: "Awesome!", style: .cancel)
        alertCtrl.addAction(action: okButton)
        self.present(alertCtrl, animated: true, completion: nil)
    }
    
}
