//
//  LoginViewController.swift
//  HomeSoulApp
//
//  Created by Durgesh Pandey on 12/04/18.
//  Copyright © 2018 HomeSoul. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FacebookLogin
import FacebookCore
import GoogleSignIn

class LoginViewController: UIViewController {
    
    @IBOutlet weak var textFieldMobile: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var buttonSignUp: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setUpViews()
        
        //Load Dashboard Explicitly
        //AppInstances.appDelegate.loadDashboardScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Hide Navigation Bar
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setUpViews() {
        self.buttonSignUp.layer.borderWidth = 1.0
        self.buttonSignUp.layer.borderColor = UIColor.darkGray.cgColor
        
        self.buttonLogin.layer.borderWidth = 1.0
        self.buttonLogin.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    // MARK: - FB User Data
    // MARK: -
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    print(result!)
                }
            })
        }
    }
    
    // MARK: - Actions
    // MARK: -
    @IBAction func buttonLoginTapped(_ sender: Any) {
        
        let isValid = self.validateLoginCredentials().isValid
        let loginErrMesage = self.validateLoginCredentials().errorMessage
        
        if isValid {
            
            //Logged In Successfully
            //Load Dashboard Screen
            AppInstances.appDelegate.loadDashboardScreen()
        } else {
            
            let errorMessage = String.init(format: "Please Enter %@", loginErrMesage)
            let alert = UIAlertController(style: .alert, title: "Error", message: errorMessage)
            alert.setMessage(font: .systemFont(ofSize: 14), color: .black)
            alert.addAction(title: "Ok")
            alert.show(animated: true, vibrate: true) {
            }
        }
    }
    
    @IBAction func buttonSignUpTapped(_ sender: Any) {
        
        //Navigate to Sign Up Screen
        self.performSegue(withIdentifier: "SignUpViewController", sender: nil)
    }
    
    @IBAction func buttonForgotPasswordTapped(_ sender: Any) {
    }
    
    @IBAction func buttonLoginWithFacebookTapped(_ sender: Any) {
        
        let loginManager = LoginManager()
        
        loginManager.logIn(readPermissions: [.publicProfile, .email], viewController: self) { loginResult in
            
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success( _, _, _):
                self.getFBUserData()
            }
        }
    }
    
    @IBAction func buttonLoginWithGoogleTapped(_ sender: Any) {
        GIDSignIn.sharedInstance().delegate=self
        GIDSignIn.sharedInstance().uiDelegate=self
        GIDSignIn.sharedInstance().signIn()
    }
    
    func validateLoginCredentials() -> (isValid: Bool, errorMessage: String) {
        var isValid = true
        var errorMessage = ""
        
        if (self.textFieldMobile.text?.isEmpty)! {
            isValid = false
            errorMessage += "Valid Mobile/Email"
        }
        
        if (self.textFieldPassword.text?.isEmpty)! {
            isValid = false
            errorMessage += errorMessage.isEmpty ? "": " and "
            errorMessage += "Valid Password"
        }
        
        return (isValid, errorMessage)
    }
}

// MARK: - Google Sign In
// MARK: -
extension LoginViewController: GIDSignInUIDelegate, GIDSignInDelegate {
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        
    }
    
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if (error == nil) {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            
            
        } else {
            print("\(error.localizedDescription)")
        }
    }
}
