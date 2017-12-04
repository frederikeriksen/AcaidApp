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
    
    // Initialize firebase with reference
    init() {
    
        self.firebaseRef = Database.database().reference()
    
    }
    
    // Function for logging in a user
    func loginUser(email: String, password: String) {
    
        Auth.auth().signIn(withEmail: email, password: password, completion: {(user, error) in
        
            if let error = error {
            
                print(error.localizedDescription)
                LoginViewController().displayLoginError(message: "Wrong login credentials. Try again!")
            
            } else {
            
                let userID = Auth.auth().currentUser?.uid
                self.firebaseRef.child(userID!).observeSingleEvent(of: .value, with: {(snapshot) in
                
                    // Init user
                
                })
            
            }
        
        })
    
    }
    
    // Function for registering a user in the database
    func regUser(firstname: String, lastname: String, email: String, password: String, university: String, studyline: String) {
    
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
                    
                    ])
                print("Successfully registered!")
            
            }
        
        })
    
    }
    
    // Function for creating a tutoring session or tutoring request
    func createSession(title: String, description: String, type: String, initiator: String) {
        self.firebaseRef.child("Sessions").childByAutoId().setValue([
                "title": title,
                "description": description,
                "type": type,
                "initiator": initiator
              
            ])
        print("Session created!")
    }
    
    // Function for putting a book for sale and store it in Firebase
    func bookCreation(title: String, description: String, course: String, semester: String, initiator: String, type: String, price: String) {
        self.firebaseRef.child("Books").childByAutoId().setValue([
            "title": title,
            "description": description,
            "course": course,
            "semester": semester,
            "initiator": initiator,
            "type": type,
            "price": price
            ])
        print("Book published for sale")
    }
    

}
