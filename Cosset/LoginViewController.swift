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
        
        let ref = Firebase(url: "https://cosset.firebaseio.com/")
        let facebookLogin = FBSDKLoginManager()
        let facebookReadPermissions = ["email"]
        
        facebookLogin.logInWithReadPermissions(facebookReadPermissions, fromViewController: self, handler: {
          (facebookResult, facebookError) -> Void in
            
            print("attempting to login")
            
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
                            print("Logged in! \(authData)")
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
