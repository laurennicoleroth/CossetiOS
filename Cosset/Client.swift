//
//  Client.swift
//  Cosset
//
//  Created by Lauren Nicole Roth on 12/29/15.
//  Copyright © 2015 Cosset. All rights reserved.
//

import Foundation
import Firebase

struct Client {
    let cid: String
    let email: String
    
    //Initialize from Firebase
    init(authData: FAuthData) {
        cid = authData.uid
        email = authData.providerData["email"] as! String
    }
    
    //Initialize from arbitrary data
    init(cid: String, email: String) {
        self.cid = cid
        self.email = email
    }
}