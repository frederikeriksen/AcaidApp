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
    let acaidLabel = UILabel()
    let emailField = UITextField()
    let passField = UITextField()
    let loginButton = UIButton()
    let regButton = UIButton()
    
    var alertView: UIAlertController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*-----------VIEW SETUP BEGIN----------*/
        
        self.view.backgroundColor = UIColor.white
        
        // Setup ImageView for logo + logo
        logoImageView.backgroundColor = UIColor.white
        logoImageView.image = logoImage
        logoImageView.frame.size.height = self.view.frame.size.height / 3
        logoImageView.frame.size.width = self.view.frame.size.width
        logoImageView.center.x = self.view.center.x
        logoImageView.frame.origin.y = 0
    
        // AcaidLabel setup
        acaidLabel.frame.size.height = 80
        acaidLabel.frame.size.width = self.view.frame.size.width
        acaidLabel.frame.origin.y = logoImageView.center.y + 20
        acaidLabel.center.x = self.view.center.x
        acaidLabel.text = "Acaid"
        acaidLabel.textColor = UIColor(red: 0, green: 0.4118, blue: 0.5843, alpha: 1.0)
        acaidLabel.font = UIFont.boldSystemFont(ofSize: 48)
        acaidLabel.textAlignment = .center
        
        // Setup email textfield
        emailField.placeholder = "Student Email"
        emailField.borderStyle = UITextBorderStyle.roundedRect
        emailField.frame.size.width = self.view.frame.size.width / 1.5
        emailField.frame.size.height = 50
        emailField.center.x = self.view.center.x
        emailField.frame.origin.y = logoImageView.frame.size.height + 40
        emailField.layer.borderColor = UIColor(red: 0, green: 0.4118, blue: 0.5843, alpha: 1.0).cgColor
        emailField.layer.borderWidth = 1.5
        emailField.autocapitalizationType = UITextAutocapitalizationType.none
        
        // Setup password textfield
        passField.placeholder = "Password"
        passField.borderStyle = UITextBorderStyle.roundedRect
        passField.frame.size.width = self.view.frame.size.width / 1.5
        passField.frame.size.height = 50
        passField.center.x = self.view.center.x
        passField.frame.origin.y = emailField.frame.origin.y + 80
        passField.layer.borderColor = UIColor(red: 0, green: 0.4118, blue: 0.5843, alpha: 1.0).cgColor
        passField.layer.borderWidth = 1.5
        passField.autocapitalizationType = UITextAutocapitalizationType.none
        passField.isSecureTextEntry = true
        
        // Setup buttons
        loginButton.backgroundColor = UIColor(red: 0, green: 0.4118, blue: 0.5843, alpha: 1.0)
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        loginButton.layer.cornerRadius = 5
        loginButton.frame.size.width = self.view.frame.size.width / 2.5
        loginButton.frame.size.height = 50
        loginButton.center.x = self.view.center.x
        loginButton.frame.origin.y = passField.frame.origin.y + 100
        loginButton.isUserInteractionEnabled = true
        //loginButton.addTarget(self, action: #selector(handleLogin(sender:)), for: .touchUpInside)
        
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
        self.view.addSubview(acaidLabel)
        self.view.addSubview(emailField)
        self.view.addSubview(passField)
        self.view.addSubview(loginButton)
        self.view.addSubview(regButton)
        
        /*--------------View Setup Done----------------*/
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loginButton.addTarget(self, action: #selector(handleLogin(sender:)), for: .touchUpInside)
    }
    
    func handleLogin(sender: UIButton) {
    
        let emailTyped = emailField.text!
        let passwordTyped = passField.text!
        
        // Initial validation to check if user has actually typed something
        if(emailTyped.isEmpty || passwordTyped.isEmpty) {
        
            displayLoginError(message: "Please type email and password!")
        
        } else {
        
            // Here we call firebase's login function and presents the main view controller of the app (tabbarcontroller)
            DBService().loginUser(email: emailTyped, password: passwordTyped)
            let tabVC = TabBarController()
            self.present(tabVC, animated: true, completion: nil)
        
        }
    
    }
    
    func goToRegisterScreen(sender: UIButton) {
    
        // User presses register button and we present them the register screen
        let nextVC = FirstRegisterViewController()
        self.present(nextVC, animated: true, completion: nil)
    
    }
    
    func displayLoginError(message: String) {
        
        self.alertView = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        alertView?.addAction(okAction)
        
        self.present(alertView!, animated: true, completion: nil)
        
    }

}
