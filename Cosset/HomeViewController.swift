//
//  HomeViewController.swift
//  Cosset
//
//  Created by Lauren Nicole Roth on 12/29/15.
//  Copyright © 2015 Cosset. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    let ref = Firebase(url: "https://cosset.firebaseio.com/")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listenForLoginState()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func listenForLoginState() {
        
        
        let handle = ref.observeAuthEventWithBlock({ authData in
            if authData != nil {
                print("Welcome, \(authData.providerData["displayName"]!)")
            } else {
                print("User is not logged in.")
            }
        
        })
        
        ref.removeAuthEventObserverWithHandle(handle)
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
