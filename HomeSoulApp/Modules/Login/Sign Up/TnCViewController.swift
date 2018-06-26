//
//  TnCViewController.swift
//  HomeSoulApp
//
//  Created by Durgesh Pandey on 26/06/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import UIKit
import WebKit

class TnCViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //Load tnc
        if let tncURL = URL.init(string: API.kGetTnCUrl) {
            let tncRequest = URLRequest(url: tncURL)
            self.webView.load(tncRequest)
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonCloseTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
