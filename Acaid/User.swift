//
//  User.swift
//  Acaid
//
//  Created by Frederik Eriksen on 27/11/2017.
//  Copyright © 2017 Acaid. All rights reserved.
//

import Foundation
import Firebase

class User {

    // User attributes
    var key: String
    var firstName: String
    var lastName: String
    var email: String
    var university: String
    var studyLine: String
    //var profilePic: URL?
    
    // Init user with snapshot from the Firebase Database
    init(snapshot: DataSnapshot) {
    
        let dict = snapshot.value as? NSDictionary
        key = snapshot.key
        firstName = dict?["firstname"] as? String ?? ""
        lastName = dict?["lastname"] as? String ?? ""
        email = dict?["email"] as? String ?? ""
        university = dict?["university"] as? String ?? ""
        studyLine = dict?["studyline"] as? String ?? ""
    
    }
    
    
}
