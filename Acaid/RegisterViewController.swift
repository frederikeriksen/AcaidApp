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
    let usernameLabel = UILabel()
    let usernameField = UITextField()
    let usernameStack = UIStackView()
    let emailLabel = UILabel()
    let emailField = UITextField()
    let emailStack = UIStackView()
    let passLabel = UILabel()
    let passField = UITextField()
    let passStack = UIStackView()
    let repPassLabel = UILabel()
    let repPassField = UITextField()
    let repPassStack = UIStackView()
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
        
        // Setup username label, field and stackview
        usernameLabel.text = "Select Username"
        usernameLabel.font = UIFont.boldSystemFont(ofSize: 10)
        usernameLabel.textColor = UIColor.black
        usernameLabel.textAlignment = .center
        usernameLabel.frame.size.height = 50
        usernameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        usernameLabel.frame.origin.x = self.view.frame.origin.x
        
        usernameField.placeholder = "Username"
        usernameField.borderStyle = UITextBorderStyle.roundedRect
        usernameField.frame.size.width = self.view.frame.size.width
        usernameField.autocapitalizationType = UITextAutocapitalizationType.none
        
        usernameStack.axis = UILayoutConstraintAxis.horizontal
        usernameStack.frame.origin.x = 0
        usernameStack.frame.origin.y = logoImageView.frame.size.height + 20
        usernameStack.frame.size.height = 50
        usernameStack.frame.size.width = self.view.frame.size.width - 5
        usernameStack.distribution = UIStackViewDistribution.fill
        usernameStack.alignment = UIStackViewAlignment.fill
        usernameStack.spacing = 0
        usernameStack.addArrangedSubview(usernameLabel)
        usernameStack.addArrangedSubview(usernameField)
        
        // Setup email label, field and stackview
        emailLabel.text = "Select Email"
        emailLabel.font = UIFont.boldSystemFont(ofSize: 10)
        emailLabel.textColor = UIColor.black
        emailLabel.textAlignment = .center
        emailLabel.frame.size.height = 50
        emailLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        emailLabel.frame.origin.x = self.view.frame.origin.x
        
        emailField.placeholder = "Email"
        emailField.borderStyle = UITextBorderStyle.roundedRect
        emailField.frame.size.width = self.view.frame.size.width
        emailField.autocapitalizationType = UITextAutocapitalizationType.none
        
        emailStack.axis = UILayoutConstraintAxis.horizontal
        emailStack.frame.origin.x = 0
        emailStack.frame.origin.y = usernameStack.frame.origin.y + 70
        emailStack.frame.size.height = 50
        emailStack.frame.size.width = self.view.frame.size.width - 5
        emailStack.distribution = UIStackViewDistribution.fill
        emailStack.alignment = UIStackViewAlignment.fill
        emailStack.spacing = 0
        emailStack.addArrangedSubview(emailLabel)
        emailStack.addArrangedSubview(emailField)
        
        // Setup password label, field and stackview
        passLabel.text = "Select Password"
        passLabel.font = UIFont.boldSystemFont(ofSize: 10)
        passLabel.textColor = UIColor.black
        passLabel.textAlignment = .center
        passLabel.frame.size.height = 50
        passLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        passLabel.frame.origin.x = self.view.frame.origin.x
        
        passField.placeholder = "Password"
        passField.borderStyle = UITextBorderStyle.roundedRect
        passField.frame.size.width = self.view.frame.size.width
        passField.autocapitalizationType = UITextAutocapitalizationType.none
        
        passStack.axis = UILayoutConstraintAxis.horizontal
        passStack.frame.origin.x = 0
        passStack.frame.origin.y = emailStack.frame.origin.y + 70
        passStack.frame.size.height = 50
        passStack.frame.size.width = self.view.frame.size.width - 5
        passStack.distribution = UIStackViewDistribution.fill
        passStack.alignment = UIStackViewAlignment.fill
        passStack.spacing = 0
        passStack.addArrangedSubview(passLabel)
        passStack.addArrangedSubview(passField)
        
        // Setup repeat password label, field and stackview
        repPassLabel.text = "Repeat Password"
        repPassLabel.font = UIFont.boldSystemFont(ofSize: 10)
        repPassLabel.textColor = UIColor.black
        repPassLabel.textAlignment = .center
        repPassLabel.frame.size.height = 50
        repPassLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        repPassLabel.frame.origin.x = self.view.frame.origin.x
        
        repPassField.placeholder = "Password"
        repPassField.borderStyle = UITextBorderStyle.roundedRect
        repPassField.frame.size.width = self.view.frame.size.width
        repPassField.autocapitalizationType = UITextAutocapitalizationType.none
        
        repPassStack.axis = UILayoutConstraintAxis.horizontal
        repPassStack.frame.origin.x = 0
        repPassStack.frame.origin.y = passStack.frame.origin.y + 70
        repPassStack.frame.size.height = 50
        repPassStack.frame.size.width = self.view.frame.size.width - 5
        repPassStack.distribution = UIStackViewDistribution.fill
        repPassStack.alignment = UIStackViewAlignment.fill
        repPassStack.spacing = 0
        repPassStack.addArrangedSubview(repPassLabel)
        repPassStack.addArrangedSubview(repPassField)
        
        // Setup buttons
        regButton.backgroundColor = UIColor.green
        regButton.setTitle("Register", for: .normal)
        regButton.setTitleColor(UIColor.black, for: .normal)
        regButton.layer.cornerRadius = 5
        regButton.frame.size.height = 50
        regButton.frame.size.width = self.view.frame.size.width / 2
        regButton.center.x = self.view.center.x
        regButton.frame.origin.y = repPassStack.frame.origin.y + 70
        regButton.isUserInteractionEnabled = true
        regButton.addTarget(self, action: #selector(handleRegistration(sender:)), for: .touchUpInside)
        
        backToLoginButton.backgroundColor = UIColor.white
        backToLoginButton.setTitle("Back to Login", for: .normal)
        backToLoginButton.setTitleColor(UIColor.black, for: .normal)
        backToLoginButton.frame.size.height = 50
        backToLoginButton.frame.size.width = self.view.frame.size.width / 2
        backToLoginButton.center.x = self.view.center.x
        backToLoginButton.frame.origin.y = regButton.frame.origin.y + 50
        backToLoginButton.isUserInteractionEnabled = true
        backToLoginButton.addTarget(self, action: #selector(goBackToLogin(sender:)), for: .touchUpInside)
        
        // Add all elements as subviews
        self.view.addSubview(logoImageView)
        self.view.addSubview(usernameStack)
        self.view.addSubview(emailStack)
        self.view.addSubview(passStack)
        self.view.addSubview(repPassStack)
        self.view.addSubview(regButton)
        self.view.addSubview(backToLoginButton)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func handleRegistration(sender: UIButton) {
    
        let usernameSelected = usernameField.text!
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
