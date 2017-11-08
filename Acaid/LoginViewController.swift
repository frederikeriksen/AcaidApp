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
        logoImageView.backgroundColor = UIColor(red: 0, green: 136, blue: 234, alpha: 1.0)
        logoImageView.image = logoImage
        logoImageView.frame.size.height = self.view.frame.size.height / 3
        logoImageView.frame.size.width = self.view.frame.size.width
        logoImageView.center.x = self.view.center.x
        logoImageView.frame.origin.y = 0
        
        // Setup email textfield
        emailField.placeholder = "Student Email"
        emailField.borderStyle = UITextBorderStyle.roundedRect
        emailField.frame.size.width = self.view.frame.size.width / 1.5
        emailField.frame.size.height = 50
        emailField.center.x = self.view.center.x
        emailField.frame.origin.y = logoImageView.frame.size.height + 40
        emailField.autocapitalizationType = UITextAutocapitalizationType.none
        
        // Setup password textfield
        passField.placeholder = "Password"
        passField.borderStyle = UITextBorderStyle.roundedRect
        passField.frame.size.width = self.view.frame.size.width / 1.5
        passField.frame.size.height = 50
        passField.center.x = self.view.center.x
        passField.frame.origin.y = emailField.frame.origin.y + 80
        passField.autocapitalizationType = UITextAutocapitalizationType.none
        passField.isSecureTextEntry = true
        
        // Setup buttons
        loginButton.backgroundColor = UIColor(red: 0, green: 136, blue: 234, alpha: 1.0)
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(UIColor.black, for: .normal)
        loginButton.layer.cornerRadius = 5
        loginButton.frame.size.width = self.view.frame.size.width / 2
        loginButton.frame.size.height = 50
        loginButton.center.x = self.view.center.x
        loginButton.frame.origin.y = passField.frame.origin.y + 100
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
        self.view.addSubview(emailField)
        self.view.addSubview(passField)
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
    
        let nextVC = FirstRegisterViewController()
        self.present(nextVC, animated: true, completion: nil)
    
    }
    
    func displayLoginError(message: String) {
        
        let myAlert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        myAlert.addAction(okAction)
        
        self.present(myAlert, animated: true, completion: nil)
        
    }

}
