//
//  SignUpViewController.swift
//  HomeSoulApp
//
//  Created by Durgesh Pandey on 13/04/18.
//  Copyright © 2018 HomeSoul. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SwiftValidator

class SignUpViewController: UIViewController, ValidationDelegate {
    
    @IBOutlet weak var textFieldsFirstName: UITextField!
    @IBOutlet weak var textFieldLastName: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPhone: UITextField!
    @IBOutlet weak var textFieldGender: UITextField!
    @IBOutlet weak var textFieldDOB: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    let validator = Validator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set Left Padding
        textFieldsFirstName.setLeftPaddingPoints(10.0)
        textFieldLastName.setLeftPaddingPoints(10.0)
        textFieldEmail.setLeftPaddingPoints(10.0)
        textFieldPhone.setLeftPaddingPoints(10.0)
        textFieldGender.setLeftPaddingPoints(10.0)
        textFieldDOB.setLeftPaddingPoints(10.0)
        textFieldPassword.setLeftPaddingPoints(10.0)
        
        //Register Validators
        self.validator.registerField(textFieldsFirstName, rules: [RequiredRule()])
        self.validator.registerField(textFieldLastName, rules: [RequiredRule()])
        self.validator.registerField(textFieldEmail, rules: [RequiredRule(), EmailRule.init(message: "Invalid EMail")])
        self.validator.registerField(textFieldPhone, rules: [RequiredRule()])
        self.validator.registerField(textFieldGender, rules: [RequiredRule()])
        self.validator.registerField(textFieldDOB, rules: [RequiredRule()])
        self.validator.registerField(textFieldPassword, rules: [RequiredRule()])
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Display Navigation Bar
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Actions
    // MARK: -
    @IBAction func buttonSignUpTapped(_ sender: Any) {
        self.validator.validate(self)
    }
    
    func validationSuccessful() {
        // submit the form
        
    }
    
    func validationFailed(_ errors:[(Validatable ,ValidationError)]) {
        
        self.resetAllBorderColors()
        
        // turn the fields to red
        for (field, _) in errors {
            if let field = field as? UITextField {
                field.layer.borderColor = UIColor.red.cgColor
                field.layer.borderWidth = 0.5
            }
        }
    }
    
    func resetAllBorderColors() {
        
        textFieldsFirstName.layer.borderColor = UIColor.clear.cgColor
        textFieldLastName.layer.borderColor = UIColor.clear.cgColor
        textFieldEmail.layer.borderColor = UIColor.clear.cgColor
        textFieldPhone.layer.borderColor = UIColor.clear.cgColor
        textFieldGender.layer.borderColor = UIColor.clear.cgColor
        textFieldDOB.layer.borderColor = UIColor.clear.cgColor
        textFieldPassword.layer.borderColor = UIColor.clear.cgColor
    }
    
    @IBAction func buttonCancelTapped(_ sender: Any) {
        
    }
    
    @IBAction func buttonSelectDOBTapped(_ sender: Any) {
        
        let alert = UIAlertController(style: .actionSheet, title: "Select date")
        alert.addDatePicker(mode: .date, date: Date(), minimumDate: nil, maximumDate: Date()) { date in
            
            //Set Date to TextFiled
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd,yyyy"
            self.textFieldDOB.text = dateFormatter.string(from: date)
        }
        alert.addAction(title: "OK", style: .cancel)
        alert.show()
    }
    
    @IBAction func buttonSelectGenderTapped(_ sender: Any) {
        
        let alert = UIAlertController(style: .actionSheet, title: "", message: "Gender")
        
        let pickerValues = ["Male", "Female", "Other"]
        let pickerViewValues: [[String]] = [pickerValues]
        let pickerViewSelectedValue: PickerViewViewController.Index = (column: 0, row: 0)
        
        alert.addPickerView(values: pickerViewValues, initialSelection: pickerViewSelectedValue) { vc, picker, index, values in
            
            //Set Value to textField
            self.textFieldGender.text = pickerValues[index.row]
            
        }
        alert.addAction(title: "Done", style: .cancel)
        alert.show()
    }
    
    
}
