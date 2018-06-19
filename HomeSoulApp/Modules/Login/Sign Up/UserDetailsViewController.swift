//
//  UserDetailsViewController.swift
//  HomeSoulApp
//
//  Created by Durgesh Pandey on 11/06/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import UIKit
import SwiftValidator

class UserDetailsViewController: UIViewController {
    
    @IBOutlet weak var textFieldFirstName: UITextField!
    @IBOutlet weak var errorLabelFirstName: UILabel!
    @IBOutlet weak var textFieldLastName: UITextField!
    @IBOutlet weak var errorLabelLastName: UILabel!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var errorLabelEmail: UILabel!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var errorLabelPassword: UILabel!
    @IBOutlet weak var textFieldPasswordConfirm: UITextField!
    @IBOutlet weak var errorLabelPasswordConfirm: UILabel!
    
    let validator = Validator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        //Register Validators
        self.validator.unregisterField(self.textFieldFirstName)
        self.validator.unregisterField(self.textFieldLastName)
        self.validator.unregisterField(self.textFieldEmail)
        self.validator.unregisterField(self.textFieldPassword)
        self.validator.unregisterField(self.textFieldPasswordConfirm)
        
        self.validator.registerField(self.textFieldFirstName, errorLabel: self.errorLabelFirstName, rules: [RequiredRule()])
        self.validator.registerField(self.textFieldLastName, errorLabel: self.errorLabelLastName, rules: [RequiredRule()])
        self.validator.registerField(self.textFieldEmail, errorLabel: self.errorLabelEmail, rules: [RequiredRule(), EmailRule()])
        self.validator.registerField(self.textFieldPassword, errorLabel: self.errorLabelPassword, rules: [RequiredRule()])
        self.validator.registerField(self.textFieldPasswordConfirm, errorLabel: self.errorLabelPasswordConfirm, rules: [RequiredRule(), ConfirmationRule.init(confirmField: self.textFieldPassword)])
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonNextTapped(_ sender: Any) {
        self.validator.validate(self)
    }
}

extension UserDetailsViewController: ValidationDelegate {
    
    func validationSuccessful() {
        
        //Validation SuccessFull
        self.performSegue(withIdentifier: "SubmitRegistrationViewController", sender: nil)
    }
    
    func validationFailed(_ errors:[(Validatable ,ValidationError)]) {
        
    }
}
