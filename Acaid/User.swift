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

    var key: String
    var firstName: String
    var lastName: String
    var email: String
    var university: String
    var studyLine: String
    var profilePic: URL?
    
    init?(snapshot: DataSnapshot) {
    
        guard let dict = snapshot.value as? [String: Any],
        let firstName = dict["firstname"] as? String,
        let lastName = dict["lastname"] as? String,
        let email = dict["email"] as? String,
        let university = dict["university"] as? String,
        let studyLine = dict["studyLine"] as? String,
        let profilePic = dict["profilePic"] as? String?
            else{
                return nil
        }
        
        self.key = snapshot.key
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.university = university
        self.studyLine = studyLine
        self.profilePic = URL(string: (profilePic)!)
    
    }
    
}
