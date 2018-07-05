//
//  PaymentMethodViewController.swift
//  HomeSoulApp
//
//  Created by Durgesh Pandey on 03/07/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import UIKit
import LTHRadioButton

class PaymentMethodViewController: UIViewController {
    
    @IBOutlet weak var radioButtonSafexPay: LTHRadioButton!
    @IBOutlet weak var radioButtonCOD: LTHRadioButton!
    
    var isSafexPay = true
    var avantServiceHelper: avantService?
    var transactionResponse: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set Up Radio Button
        self.setUpRadioButtonsUI()
        self.setUpRadioButtonsState()
    }
    
    private func setUpRadioButtonsUI() {
        self.radioButtonSafexPay.selectedColor = UIColor.orange
        self.radioButtonSafexPay.deselectedColor = UIColor.orange
        self.radioButtonCOD.selectedColor = UIColor.orange
        self.radioButtonCOD.deselectedColor = UIColor.orange
        
        //Radio Button Actions
        self.radioButtonSafexPay.onSelect {
            self.isSafexPay = true
            self.setUpRadioButtonsState()
        }
        
        self.radioButtonCOD.onSelect {
            self.isSafexPay = false
            self.setUpRadioButtonsState()
        }
    }
    
    private func setUpRadioButtonsState() {
        if self.isSafexPay {
            self.radioButtonSafexPay.select(animated: true)
            self.radioButtonCOD.deselect(animated: true)
        } else {
            self.radioButtonSafexPay.deselect(animated: true)
            self.radioButtonCOD.select(animated: true)
        }
    }
    
    @IBAction func buttonContinueTapped(_ sender: Any) {
        
        //Call Payment Gateway Here
        self.checkOut()
    }
}

extension PaymentMethodViewController {
    
    func checkOut() {
        
        let order_no = "\(arc4random() % 100000)"
        let amount = "100"
        let country = "IND"
        let currency = "INR"
        let ag_id = "paygate"
        let success_url = "https://test.avantgardepayments.com/test-transaction/MerchantSuccess.php"
        let failure_url = "https://test.avantgardepayments.com/test-transaction/MerchantFailure.php"
        let channel = "MOBILE"
        let merchant_id = "201710270001"
        let txn_type = "SALE"
        let merchant_Key = "oqUl4D0LqA4plZw4reAX/K3UKJoQdet0k/N6X6K4Y5k="
        
        //        201710270001
        //        oqUl4D0LqA4plZw4reAX/K3UKJoQdet0k/N6X6K4Y5k=
        //        _MerchentId =@"201608040001";
        //        _secretKey =@"KlLve361T2/0Ke4fcRbqOak/2ZRXxyvtsfI+ox2wVZ4=";
        
        let txn_Str = "\(ag_id)|\(merchant_id)|\(order_no)|\(amount)|\(country)|\(currency)|\(txn_type)|\(success_url)|\(failure_url)|\(channel)"
        
        
        //Payment Gateway Details
        let pg_id = ""
        let paymentMode = ""
        let scheme = ""
        let emi_months = ""
        
        var result = "NB"
        let paymentOptions = ["Net Banking","Credit Card","Debit Card","Prepaid Card","Credit Card Emi","Cash","Coin","DebitCard with Pin","UPI","Wallet"]
        if let indexForPayMode = paymentOptions.index(of: paymentMode) {
            switch indexForPayMode {
            case 0:
                result="NB";
            case 1:
                result="CC";
            case 2:
                result="DC";
            case 3:
                result="PP";
            case 4:
                result="CE";
            case 5:
                result="CA";
            case 6:
                result="CO";
            case 7:
                result="DP";
            case 8:
                result="UP";
            case 9:
                result="WA";
            default:
                break;
            }
        }
        
        let pg_Str = "\(pg_id)|\(result)|\(scheme)|\(emi_months)"
        
        // Card Details
        let card_no = ""
        let exp_month = ""
        let exp_year = ""
        let cvv2 = ""
        let card_name = ""
        
        let card_Str = "\(card_no)|\(exp_month)|\(exp_year)|\(cvv2)|\(card_name)"
        
        //Customer Details
        let cust_name = ""
        let email_id = ""
        let mobile_no = ""
        let unique_id = ""
        let is_logged_in = ""
        
        let cust_Str = "\(cust_name)|\(email_id)|\(mobile_no)|\(unique_id)|\(is_logged_in)"
        
        //Billing Details
        let bill_address = ""
        let bill_city = ""
        let bill_state = ""
        let bill_country = ""
        let bill_zip = ""
        
        let bill_Str = "\(bill_address)|\(bill_city)|\(bill_state)|\(bill_country)|\(bill_zip)"
        
        // Shipping Details
        let ship_Address = ""
        let ship_City = ""
        let ship_State = ""
        let ship_Country = ""
        let ship_Zip = ""
        let ship_days = ""
        let ship_AddressCount = 0
        
        let ship_Str = "\(ship_Address)|\(ship_City)|\(ship_State)|\(ship_Country)|\(ship_Zip)|\(ship_days)|\(ship_AddressCount)"
        
        //Item Details
        let item_count = ""
        let item_Value = ""
        let item_Category = ""
        
        let item_Str = "\(item_count)|\(item_Value)|\(item_Category)"
        
        self.avantServiceHelper = avantService.sharedController()
        self.avantServiceHelper?.delegate = self
        
        self.avantServiceHelper?.setData(merchant_Key, merchant_id, success_url, failure_url)
        
        let value = self.avantServiceHelper?.transactiondata(txn_Str, "|||", "||||", cust_Str, bill_Str, ship_Str, "||", "||||", "", "", "")
        
        // let value = self.avantServiceHelper?.transactiondata(txn_Str, "|NB||", "||||", "||||", "||||", "||||||0", "||", "||||", "", "", "")
        
        if value! {
            self.avantServiceHelper?.showTransactionPageViewController(self.navigationController)
        }
    }
}

extension PaymentMethodViewController: avantServiceDelegate {
    
    func transactionResponse(_ status: String!) {
        do {
            let paymentTransactionResponse = try PaymentTransactionResponse(status)
            
            if let transactionResponseStr = paymentTransactionResponse.txnResponse?.components(separatedBy: "|").last {
                self.transactionResponse = transactionResponseStr
                self.performSegue(withIdentifier: "ConfirmOrderViewController", sender: nil)
            }
        } catch (let error) {
            print(error)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ConfirmOrderViewController" {
            if let confirmOrder: ConfirmOrderViewController = segue.destination as? ConfirmOrderViewController {
                confirmOrder.transactionResponse = self.transactionResponse
            }
         }
    }
}

