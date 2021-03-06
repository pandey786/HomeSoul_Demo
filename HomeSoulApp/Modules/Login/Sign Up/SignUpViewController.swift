//
//  SignUpViewController.swift
//  HomeSoulApp
//
//  Created by Durgesh Pandey on 13/04/18.
//  Copyright © 2018 HomeSoul. All rights reserved.
//

import UIKit
import SwiftValidator
import IQKeyboardManagerSwift
import SinchVerification

public enum ViewState {
    case enterMobileNumber
    case enterOTP
}

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var textFieldPhone: UITextField!
    @IBOutlet weak var textFieldOTP: UITextField!
    @IBOutlet weak var buttonAction: UIButton!
    @IBOutlet weak var constraintOTPViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var errorLabelMobile: UILabel!
    @IBOutlet weak var errorLabelOTP: UILabel!
    @IBOutlet weak var labelError: UILabel!
    @IBOutlet weak var constraintErrorViewHeight: NSLayoutConstraint!
    
    var viewState: ViewState = .enterMobileNumber
    var verification: Verification!
    var applicationKey = "2NPm7l7sVU6GxpICs73Vjg=="
    
    let validator = Validator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpActionButton()
        self.displayOTPView(shouldDisplay: false)
        self.displayErrorView(shouldDisplay: false, errorText: "")
        
        validator.styleTransformers(success:{ (validationRule) -> Void in
            print("here")
            // clear error label
            validationRule.errorLabel?.isHidden = true
            validationRule.errorLabel?.text = ""
            if let textField = validationRule.field as? UITextField {
                textField.backgroundColor = UIColor.green.withAlphaComponent(0.15)
            }
        }, error:{ (validationError) -> Void in
            print("error")
            validationError.errorLabel?.isHidden = false
            validationError.errorLabel?.text = validationError.errorMessage
            if let textField = validationError.field as? UITextField {
                textField.backgroundColor = UIColor.red.withAlphaComponent(0.15)
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Display Navigation Bar
        self.navigationController?.navigationBar.isHidden = false
        self.displayOTPView(shouldDisplay: false)
        
        //Register Validators
        self.validator.unregisterField(self.textFieldOTP)
        validator.registerField(textFieldPhone, errorLabel: errorLabelMobile, rules: [RequiredRule(), PhoneNumberRule()]);
    }
    
    public func setUpActionButton() {
        switch self.viewState {
        case .enterMobileNumber:
            self.buttonAction.setTitle("Send OTP", for: .normal)
        case .enterOTP:
            self.buttonAction.setTitle("Submit OTP", for: .normal)
        }
    }
    
    public func displayOTPView(shouldDisplay: Bool) {
        
        self.viewState = shouldDisplay ? .enterOTP: .enterMobileNumber
        self.setUpActionButton()
        
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.3, animations: {
            self.constraintOTPViewHeight.constant = shouldDisplay ? 70: 0
            self.view.layoutIfNeeded()
        }) { (success) in
            
            if shouldDisplay {
                
                //Register OTP Validation
                self.validator.unregisterField(self.textFieldPhone)
                self.validator.registerField(self.textFieldOTP, errorLabel: self.errorLabelOTP, rules: [RequiredRule()]);
            }
        }
    }
    
    public func displayErrorView(shouldDisplay: Bool, errorText: String) {
        
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.3, animations: {
            self.constraintErrorViewHeight.constant = shouldDisplay ? 40: 0
            self.labelError.text = errorText
            self.view.layoutIfNeeded()
        }) { (success) in
            
        }
    }
    
    // MARK: - Actions
    // MARK: -
    @IBAction func buttonSignUpTapped(_ sender: Any) {
        self.validator.validate(self)
    }
}

extension SignUpViewController: ValidationDelegate {
    
    func validationSuccessful() {
        
        //Validation SuccessFull
        switch self.viewState {
        case .enterMobileNumber:
            
            //Call to Send OTP
            UserRegistrationService.sendOTP(self.textFieldPhone.text!) { (isSuccess, responseStr) in
                
                if isSuccess {
                    self.textFieldPhone.isEnabled = false
                    self.displayOTPView(shouldDisplay: true)
                    self.displayErrorView(shouldDisplay: false, errorText: "")
                } else {
                     self.textFieldPhone.isEnabled = true
                    self.displayOTPView(shouldDisplay: false)
                    self.displayErrorView(shouldDisplay: true, errorText: responseStr!)
                }
            }
            
        case .enterOTP:
            
            //Call to Validate OTP
            UserRegistrationService.validateOTP(self.textFieldPhone.text!, otp: self.textFieldOTP.text!) { (isSuccess, responseStr) in
                
                if isSuccess {
                    //Navigate to next Screen
                    self.performSegue(withIdentifier: "LegalNameViewController", sender: nil)
                    self.displayErrorView(shouldDisplay: false, errorText: "")
                } else {
                    self.displayErrorView(shouldDisplay: true, errorText: responseStr!)
                }
            }
        }
    }
    
    func validationFailed(_ errors:[(Validatable ,ValidationError)]) {
        
    }
}
