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

    override func viewDidLoad() {
        super.viewDidLoad()

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
                            
                         /* other options: uid, provider, token, auth, expires, providerData["id" or "accessToken" or "email"
                           or "profileImageURL" or "cachedUserProfile"] */
                            
                            ref.createUser(clientEmail, password: "randompassword123",
                                withValueCompletionBlock: { error, result in
                                    
                                    if error != nil {
                                        print("there was an error creating the account: \(error)")
                                    } else {
                                        let uid = result["uid"] as? String
                                        print("Successfully created user account with uid: \(uid)")
                                    }
                            })
                        }
                })
            }
        
        })
        
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
