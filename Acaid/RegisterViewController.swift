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
    let backToLoginButton = UIButton()
    
    let firebaseRef = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        // Setup imageview for logo image
        logoImageView.backgroundColor = UIColor.green
        logoImageView.image = logoImage
        logoImageView.frame.size.height = self.view.frame.size.height / 3
        logoImageView.frame.size.width = self.view.frame.size.width
        logoImageView.center.x = self.view.center.x
        logoImageView.frame.origin.y = 0
        
        // Setup firstname textfield
        firstNameField.placeholder = "First name"
        firstNameField.borderStyle = UITextBorderStyle.roundedRect
        firstNameField.frame.size.width = self.view.frame.size.width / 1.5
        firstNameField.frame.size.height = 40
        firstNameField.center.x = self.view.center.x
        firstNameField.frame.origin.y = logoImageView.frame.size.height + 20
        firstNameField.autocapitalizationType = UITextAutocapitalizationType.none
        
        // Setup lastname textfield
        lastNameField.placeholder = "Last name"
        lastNameField.borderStyle = UITextBorderStyle.roundedRect
        lastNameField.frame.size.width = self.view.frame.size.width / 1.5
        lastNameField.frame.size.height = 40
        lastNameField.center.x = self.view.center.x
        lastNameField.frame.origin.y = firstNameField.frame.origin.y + 60
        firstNameField.autocapitalizationType = UITextAutocapitalizationType.none
        
        // Setup email textfield
        emailField.placeholder = "Choose Email"
        emailField.borderStyle = UITextBorderStyle.roundedRect
        emailField.frame.size.width = self.view.frame.size.width / 1.5
        emailField.frame.size.height = 40
        emailField.center.x = self.view.center.x
        emailField.frame.origin.y = lastNameField.frame.origin.y + 60
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
        regButton.backgroundColor = UIColor.green
        regButton.setTitle("Register", for: .normal)
        regButton.setTitleColor(UIColor.black, for: .normal)
        regButton.layer.cornerRadius = 5
        regButton.frame.size.height = 50
        regButton.frame.size.width = self.view.frame.size.width / 1.5
        regButton.center.x = self.view.center.x
        regButton.frame.origin.y = repPassField.frame.origin.y + 70
        regButton.isUserInteractionEnabled = true
        regButton.addTarget(self, action: #selector(handleRegistration(sender:)), for: .touchUpInside)
        
        backToLoginButton.backgroundColor = UIColor.white
        backToLoginButton.setTitle("Back to Login", for: .normal)
        backToLoginButton.setTitleColor(UIColor.black, for: .normal)
        backToLoginButton.frame.size.height = 50
        backToLoginButton.frame.size.width = self.view.frame.size.width / 1.5
        backToLoginButton.center.x = self.view.center.x
        backToLoginButton.frame.origin.y = regButton.frame.origin.y + 50
        backToLoginButton.isUserInteractionEnabled = true
        backToLoginButton.addTarget(self, action: #selector(goBackToLogin(sender:)), for: .touchUpInside)
        
        // Add all elements as subviews
        self.view.addSubview(logoImageView)
        self.view.addSubview(firstNameField)
        self.view.addSubview(lastNameField)
        self.view.addSubview(emailField)
        self.view.addSubview(passField)
        self.view.addSubview(repPassField)
        self.view.addSubview(regButton)
        self.view.addSubview(backToLoginButton)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func handleRegistration(sender: UIButton) {
    
        let usernameSelected = firstNameField.text! + " " + lastNameField.text!
        let emailSelected = emailField.text!
        let passwordSelected = passField.text!
        let repeatedPassword = repPassField.text!
        
        let usernameLength = usernameSelected.characters.count
        let passwordLength = passwordSelected.characters.count
        
        if (usernameSelected.isEmpty || emailSelected.isEmpty || passwordSelected.isEmpty) {
        
            displayError(message: "Please fill out all fields!")
        
        } else if (passwordLength < 7) {
        
            displayError(message: "Passwords are required to be at least 7 characters long!")
        
        } else if (passwordSelected != repeatedPassword) {
        
            displayError(message: "The passwords must match! Try again!")
        
        } else if (usernameLength < 5) {
        
            displayError(message: "Usernames are required to be at least 5 characters long!")
        
        } else {
        
            // Initial validation has been done and we now register the user in the database
            DBService().regUser(username: usernameSelected, email: emailSelected, password: passwordSelected)
            
            let nextVC = TabBarController()
            self.present(nextVC, animated: true, completion: nil)
            
        }
    
    
    }
    
    func goBackToLogin(sender: UIButton) {
    
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
