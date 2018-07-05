//
//  SplashViewController.swift
//  HomeSoulApp
//
//  Created by Durgesh Pandey on 12/04/18.
//  Copyright © 2018 HomeSoul. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set App Session
        AppSessionManager.getAPIToken { (isSucess, api_Token) in
            print("api_Token:- \(String(describing: api_Token))")
        }
        
        self.navigateToLoginScreen()
    }
    
    func navigateToLoginScreen() {
        
        //Load Login Screen
        AppInstances.appDelegate.loadLoginScreen()
    }
    
    func navigateToDashboardScreen() {
        
        //Load Login Screen
        AppInstances.appDelegate.loadDashboardScreen()
    }
    
}
