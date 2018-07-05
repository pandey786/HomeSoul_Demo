//
//  ConfirmOrderViewController.swift
//  HomeSoulApp
//
//  Created by Durgesh Pandey on 03/07/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import UIKit
import Lottie

public enum TransactionStatus {
    case success
    case failed
    case canceled
}

class ConfirmOrderViewController: UIViewController {
    
    var transactionResponse: String?
    var transactionStatus: TransactionStatus = .failed
    
    @IBOutlet weak var labelPaymentStatus: UILabel!
    @IBOutlet weak var labelOrderStatus: UILabel!
    @IBOutlet weak var labelUserInfo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Hide Back Button
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        self.setTransactionStatus()
        self.setOrderStatusUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setOrderStatusUI() {
        self.setAnimation()
        
        switch self.transactionStatus {
        case .success:
            self.labelPaymentStatus.text = "Payment Successfull"
            self.labelOrderStatus.text = "Your Order is Placed"
            self.labelUserInfo.text = "Thanks for Shopping with Us."
        case .failed, .canceled:
            self.labelPaymentStatus.text = "Payment Failed"
            self.labelOrderStatus.text = "Order could not be processed"
            self.labelUserInfo.text = "Please retry once again from your Cart"
        }
    }
    
    private func setAnimation() {
        
        let animFileName = self.transactionStatus == .success ? "success": "failed"
        let animationView = LOTAnimationView(name: animFileName)
        animationView.contentMode = .scaleAspectFill
        animationView.frame = CGRect.init(x: self.view.center.x - 75, y: self.view.center.y - 150, width: 150, height: 150)
        animationView.loopAnimation = true
        self.view.addSubview(animationView)
        animationView.play{ (finished) in
        }
    }
    
    private func setTransactionStatus() {
        
        if let transResponseStr = self.transactionResponse {
            
            switch transResponseStr {
                
            case "Successful":
                self.transactionStatus = .success
            case "Transaction cancelled by the customer.":
                self.transactionStatus = .canceled
            case "Received fail response from the bank.":
                self.transactionStatus = .failed
            default:
                break
            }
        }
    }
    
}
