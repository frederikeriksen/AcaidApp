//
//  DBService.swift
//  Acaid
//
//  Created by Frederik Eriksen on 02/11/2017.
//  Copyright © 2017 Acaid. All rights reserved.
//

import Foundation
import Firebase

class DBService {

    private var firebaseRef : DatabaseReference
    
    init() {
    
        self.firebaseRef = Database.database().reference()
    
    }
    
    func loginUser(email: String, password: String) {
    
        Auth.auth().signIn(withEmail: email, password: password, completion: {(user, error) in
        
            if let error = error {
            
                print(error.localizedDescription)
                LoginViewController().displayLoginError(message: "Wrong login credentials. Try again!")
            
            } else {
            
                let userID = Auth.auth().currentUser?.uid
                self.firebaseRef.child(userID!).observeSingleEvent(of: .value, with: {(snapshot) in
                
                    let value = snapshot.value as? NSDictionary
                
                })
            
            }
        
        })
    
    }
    
    func regUser(firstname: String, lastname: String, email: String, password: String, university: String, studyline: String, isTutor: Bool) {
    
        Auth.auth().createUser(withEmail: email, password: password, completion: {(user, error)in
        
            if let error = error {
            
                print(error.localizedDescription)
                RegisterViewController().displayError(message: "Invalid email address, try again!")
                
            
            } else {
            
                self.firebaseRef.child("Users").child(user!.uid).setValue([
                    
                        "firstname": firstname,
                        "lastname": lastname,
                        "email": email,
                        "password": password,
                        "university": university,
                        "studyline": studyline,
                        "isTutor": false
                    
                    ])
                print("Successfully registered!")
            
            }
        
        })
    
    }
    
    func createSession(title: String, description: String, type: String, initiator: String) {
        self.firebaseRef.child("Sessions").childByAutoId().setValue([
                "title": title,
                "description": description,
                "type": type,
                "initiator": initiator
              
            ])
        print("Session created!")
    }
    

}
