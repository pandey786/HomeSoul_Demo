//
//  SubmitRegistrationViewController.swift
//  HomeSoulApp
//
//  Created by Durgesh Pandey on 11/06/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import UIKit

class SubmitRegistrationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonTnCTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "TnCViewController", sender: nil)
    }
    
    @IBAction func buttonContinueTapped(_ sender: Any) {
        
        //Submit Registration
    }
    
}
