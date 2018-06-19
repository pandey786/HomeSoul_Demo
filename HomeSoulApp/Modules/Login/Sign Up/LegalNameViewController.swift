//
//  LegalNameViewController.swift
//  HomeSoulApp
//
//  Created by Durgesh Pandey on 11/06/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import UIKit
import SwiftValidator

class LegalNameViewController: UIViewController {
    
    @IBOutlet weak var textFieldLegalName: UITextField!
    @IBOutlet weak var errorLabelLegalName: UILabel!
    
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
        self.validator.unregisterField(self.textFieldLegalName)
        validator.registerField(textFieldLegalName, errorLabel: errorLabelLegalName, rules: [RequiredRule()]);
    }
    
    @IBAction func buttonNextTapped(_ sender: Any) {
        self.validator.validate(self)
    }
}

extension LegalNameViewController: ValidationDelegate {
    
    func validationSuccessful() {
        
        //Validation SuccessFull
        self.performSegue(withIdentifier: "AccountTypeViewController", sender: nil)
    }
    
    func validationFailed(_ errors:[(Validatable ,ValidationError)]) {
        
    }
}
