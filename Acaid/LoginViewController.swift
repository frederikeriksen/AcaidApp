//
//  LoginViewController.swift
//  Acaid
//
//  Created by Frederik Eriksen on 10/10/2017.
//  Copyright © 2017 Acaid. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    let logoImageView = UIImageView()
    let logoImage = UIImage()
    let emailLabel = UILabel()
    let emailField = UITextField()
    let emailStack = UIStackView()
    let passLabel = UILabel()
    let passField = UITextField()
    let passStack = UIStackView()
    let loginButton = UIButton()
    let regButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        // Setup ImageView for logo + logo
        logoImageView.backgroundColor = UIColor.green
        logoImageView.image = logoImage
        logoImageView.frame.size.height = self.view.frame.size.height / 3
        logoImageView.frame.size.width = self.view.frame.size.width
        logoImageView.center.x = self.view.center.x
        logoImageView.frame.origin.y = 0
        
        // Setup email label, email textfield and put into stackview
        emailLabel.text = "Email"
        emailLabel.font = UIFont.boldSystemFont(ofSize: 12)
        emailLabel.textColor = UIColor.black
        emailLabel.textAlignment = .center
        emailLabel.frame.size.height = 50
        emailLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        emailLabel.frame.origin.x = 0
        
        emailField.placeholder = "Email Address"
        emailField.borderStyle = UITextBorderStyle.roundedRect
        emailField.frame.size.width = self.view.frame.size.width
        emailField.autocapitalizationType = UITextAutocapitalizationType.none
        
        emailStack.axis = UILayoutConstraintAxis.horizontal
        emailStack.frame.origin.x = 0
        emailStack.frame.origin.y = logoImageView.frame.size.height + 50
        emailStack.frame.size.height = 50
        emailStack.frame.size.width = self.view.frame.size.width - 5
        emailStack.distribution = UIStackViewDistribution.fill
        emailStack.alignment = UIStackViewAlignment.fill
        emailStack.spacing = 0
        emailStack.addArrangedSubview(emailLabel)
        emailStack.addArrangedSubview(emailField)
        
        // Setup password label, password field and put into stackview
        passLabel.text = "Password"
        passLabel.font = UIFont.boldSystemFont(ofSize: 12)
        passLabel.textColor = UIColor.black
        passLabel.textAlignment = .center
        passLabel.frame.size.height = 50
        passLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        passLabel.frame.origin.x = 0
        
        passField.placeholder = "Password"
        passField.borderStyle = UITextBorderStyle.roundedRect
        passField.frame.size.width = self.view.frame.size.width
        passField.autocapitalizationType = UITextAutocapitalizationType.none
        passField.isSecureTextEntry = true
        
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
        
        // Setup buttons
        loginButton.backgroundColor = UIColor.green
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(UIColor.black, for: .normal)
        loginButton.layer.cornerRadius = 5
        loginButton.frame.size.width = self.view.frame.size.width / 2
        loginButton.frame.size.height = 50
        loginButton.center.x = self.view.center.x
        loginButton.frame.origin.y = passStack.frame.origin.y + 100
        loginButton.isUserInteractionEnabled = true
        loginButton.addTarget(self, action: #selector(handleLogin(sender:)), for: .touchUpInside)
        
        regButton.backgroundColor = UIColor.white
        regButton.setTitle("Register", for: .normal)
        regButton.setTitleColor(UIColor.black, for: .normal)
        regButton.frame.size.width = self.view.frame.size.width / 2
        regButton.frame.size.height = 50
        regButton.center.x = self.view.center.x
        regButton.frame.origin.y = loginButton.frame.origin.y + 50
        regButton.isUserInteractionEnabled = true
        regButton.addTarget(self, action: #selector(goToRegisterScreen(sender:)), for: .touchUpInside)
        
        // Add every element as a subview
        self.view.addSubview(logoImageView)
        self.view.addSubview(emailStack)
        self.view.addSubview(passStack)
        self.view.addSubview(loginButton)
        self.view.addSubview(regButton)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func handleLogin(sender: UIButton) {
    
        let emailTyped = emailField.text!
        let passwordTyped = passField.text!
        
        if(emailTyped.isEmpty || passwordTyped.isEmpty) {
        
            displayLoginError(message: "Please type email and password!")
        
        } else {
        
            DBService().loginUser(email: emailTyped, password: passwordTyped)
            let tabVC = TabBarController()
            self.present(tabVC, animated: true, completion: nil)
        
        }
    
    }
    
    func goToRegisterScreen(sender: UIButton) {
    
        let nextVC = RegisterViewController()
        self.present(nextVC, animated: true, completion: nil)
    
    }
    
    func displayLoginError(message: String) {
        
        let myAlert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        myAlert.addAction(okAction)
        
        self.present(myAlert, animated: true, completion: nil)
        
    }

}
