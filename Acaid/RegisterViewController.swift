//
//  RegisterViewController.swift
//  Acaid
//
//  Created by Frederik Eriksen on 10/10/2017.
//  Copyright © 2017 Acaid. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    let logoImageView = UIImageView()
    let logoImage = UIImage()
    let firstNameField = UITextField()
    let lastNameField = UITextField()
    let emailField = UITextField()
    let passField = UITextField()
    let repPassField = UITextField()
    let regButton = UIButton()
    let backButton = UIButton()
    
    var firstNameHolder = ""
    var lastNameHolder = ""
    var universityHolder = ""
    var studyLineHolder = ""
    
    let firebaseRef = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        // Setup imageview for logo image
        logoImageView.backgroundColor = UIColor(red: 0, green: 0.4118, blue: 0.5843, alpha: 1.0)
        logoImageView.image = logoImage
        logoImageView.frame.size.height = self.view.frame.size.height / 3
        logoImageView.frame.size.width = self.view.frame.size.width
        logoImageView.center.x = self.view.center.x
        logoImageView.frame.origin.y = 0
        
        // Setup email textfield
        emailField.placeholder = "Choose Email"
        emailField.borderStyle = UITextBorderStyle.roundedRect
        emailField.frame.size.width = self.view.frame.size.width / 1.5
        emailField.frame.size.height = 40
        emailField.center.x = self.view.center.x
        emailField.frame.origin.y = logoImageView.frame.size.height + 30
        emailField.autocapitalizationType = UITextAutocapitalizationType.none
        
        // Setup password textfield
        passField.placeholder = "Choose Password"
        passField.borderStyle = UITextBorderStyle.roundedRect
        passField.frame.size.width = self.view.frame.size.width / 1.5
        passField.frame.size.height = 40
        passField.center.x = self.view.center.x
        passField.frame.origin.y = emailField.frame.origin.y + 60
        passField.autocapitalizationType = UITextAutocapitalizationType.none
        
        // Setup repeat password textfield
        repPassField.placeholder = "Repeat Password"
        repPassField.borderStyle = UITextBorderStyle.roundedRect
        repPassField.frame.size.width = self.view.frame.size.width / 1.5
        repPassField.frame.size.height = 40
        repPassField.center.x = self.view.center.x
        repPassField.frame.origin.y = passField.frame.origin.y + 60
        repPassField.autocapitalizationType = UITextAutocapitalizationType.none
        
        // Setup buttons
        regButton.backgroundColor = UIColor(red: 0, green: 0.4118, blue: 0.5843, alpha: 1.0)
        regButton.setTitle("Register", for: .normal)
        regButton.setTitleColor(UIColor.black, for: .normal)
        regButton.layer.cornerRadius = 5
        regButton.frame.size.height = 40
        regButton.frame.size.width = self.view.frame.size.width / 4
        regButton.frame.origin.x = self.view.frame.maxX - regButton.frame.size.width - 5
        regButton.frame.origin.y = repPassField.frame.origin.y + 70
        regButton.isUserInteractionEnabled = true
        regButton.addTarget(self, action: #selector(handleRegistration(sender:)), for: .touchUpInside)
        
        backButton.backgroundColor = UIColor.white
        backButton.setTitle("< Back", for: .normal)
        backButton.setTitleColor(UIColor(red: 0, green: 0.4118, blue: 0.5843, alpha: 1.0), for: .normal)
        backButton.frame.size.height = 50
        backButton.frame.size.width = self.view.frame.size.width / 5
        backButton.frame.origin.x = self.view.frame.origin.x + 5
        backButton.frame.origin.y = regButton.frame.origin.y
        backButton.isUserInteractionEnabled = true
        backButton.addTarget(self, action: #selector(goBackToLogin(sender:)), for: .touchUpInside)
        
        // Add all elements as subviews
        self.view.addSubview(logoImageView)
        self.view.addSubview(firstNameField)
        self.view.addSubview(lastNameField)
        self.view.addSubview(emailField)
        self.view.addSubview(passField)
        self.view.addSubview(repPassField)
        self.view.addSubview(regButton)
        self.view.addSubview(backButton)
        
    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func handleRegistration(sender: UIButton) {
    
        let firstName = firstNameHolder
        let lastName = lastNameHolder
        let university = universityHolder
        let studyLine = studyLineHolder
        let emailSelected = emailField.text!
        let passwordSelected = passField.text!
        let repeatedPassword = repPassField.text!
        
        let passwordLength = passwordSelected.characters.count
        
        if (emailSelected.isEmpty || passwordSelected.isEmpty) {
        
            displayError(message: "Please fill out all fields!")
        
        } else if (passwordLength < 7) {
        
            displayError(message: "Passwords are required to be at least 7 characters long!")
        
        } else if (passwordSelected != repeatedPassword) {
        
            displayError(message: "The passwords must match! Try again!")
        
        } else {
        
            // Initial validation has been done and we now register the user in the database
            DBService().regUser(firstname: firstName, lastname: lastName, email: emailSelected, password: passwordSelected, university: university, studyline: studyLine)
            
            let nextVC = TabBarController()
            self.present(nextVC, animated: true, completion: nil)
            
            
            
        }
    
    
    }
    
    func goBackToLogin(sender: UIButton) {
    
        // User goes back and we present them the login view
        let loginVC = LoginViewController()
        self.present(loginVC, animated: true, completion: nil)
    
    }
    
    func displayError(message: String) {
    
        let myAlert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        myAlert.addAction(okAction)
        
        self.present(myAlert, animated: true, completion: nil)
    
    }
    


}
