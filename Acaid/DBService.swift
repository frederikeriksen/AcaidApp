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
                    let username = value?["username"] as? String ?? ""
                    let email = value?["email"] as? String ?? ""
                    let password = value?["password"] as? String ?? ""
                
                })
            
            }
        
        })
    
    }
    
    func regUser(username: String, email: String, password: String) {
    
        Auth.auth().createUser(withEmail: email, password: password, completion: {(user, error)in
        
            if let error = error {
            
                print(error.localizedDescription)
                RegisterViewController().displayError(message: "Invalid email address, try again!")
                
            
            } else {
            
                self.firebaseRef.child("Users").child(user!.uid).setValue([
                    
                        "username": username,
                        "email": email,
                        "password": password,
                    
                    ])
                print("Successfully registered!")
            
            }
        
        })
    
    }
    
    func getUserData() {
    
        
    
    }
    
    

}
