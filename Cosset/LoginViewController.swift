//
//  LoginViewController.swift
//  Cosset
//
//  Created by Lauren Nicole Roth on 12/29/15.
//  Copyright © 2015 Cosset. All rights reserved.
//

import UIKit
import FBSDKShareKit
import FBSDKLoginKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Hello from LoginViewController")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LoginWithFacebookClicked(sender: AnyObject) {
        
        print("Sign me in please")
        
        let ref = Firebase(url: "https://cosset.firebaseio.com/clients")
        let facebookLogin = FBSDKLoginManager()
        let facebookReadPermissions = ["public_profile", "email"]
        
        facebookLogin.logInWithReadPermissions(facebookReadPermissions, fromViewController: self, handler: {
          (facebookResult, facebookError) -> Void in
            
            print("Facebook logging in with read permissions.")
            
            if facebookError != nil {
                print("Facebook login failed. Error \(facebookError)")
            } else if facebookResult.isCancelled {
                print("Facebook login was cancelled.")
            } else {
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                
                ref.authWithOAuthProvider("facebook", token: accessToken,
                    withCompletionBlock: { error, authData in
                        
                        if error != nil {
                            print("Login failed. \(error)")
                        } else {
                            print("Logged in! \(authData.uid)")

                            let clientEmail = authData.providerData["email"] as! String
                            let password = "SomeRandomPassword123"
                            
                            self.createUserOnFirebase(clientEmail, password: password)
                            
                        }
                })
            }
        
        })
        
    }
    
    func createUserOnFirebase(email: String, password: String) {
        let ref = Firebase(url: "https://cosset.firebaseio.com/clients")
        
        print("Creating user \(email) on Firebase")
        
        ref.createUser(email, password: password,
            withValueCompletionBlock: { error, result in
                
                if error != nil {
                    print("there was an error creating the account: \(error)")
                } else {
                    let uid = result["uid"] as? String
                    print("Successfully created user account with uid: \(uid)")
                }
        })

    }
    
    @IBAction func loginWithEmailButtonClicked(sender: AnyObject) {
        
        let email = emailTextField.text
        let password = passwordTextField.text
        
        if email != Optional("") && password != Optional("") {
            loginToFirebase(email!, password: password!)
        } else {
            print("Text fields were left empty.")
        }
        
    }
    
    func loginToFirebase(email: String, password: String) {
        print("Login attempted with \(email) and \(password)")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
