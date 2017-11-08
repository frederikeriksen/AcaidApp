//
//  FirstRegisterViewController.swift
//  Acaid
//
//  Created by Frederik Eriksen on 08/11/2017.
//  Copyright © 2017 Acaid. All rights reserved.
//

import UIKit

class FirstRegisterViewController: UIViewController {
    
    let logoImageView = UIImageView()
    let logoImage = UIImage()
    let firstNameField = UITextField()
    let lastNameField = UITextField()
    let universityField = UITextField()
    let studyLineField = UITextField()
    let nextButton = UIButton()
    let cancelButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white

        // Setup logo imageview and image
        logoImageView.backgroundColor = UIColor(red: 0, green: 136, blue: 234, alpha: 1.0)
        logoImageView.image = logoImage
        logoImageView.frame.size.height = self.view.frame.size.height / 3
        logoImageView.frame.size.width = self.view.frame.size.width
        logoImageView.center.x = self.view.center.x
        logoImageView.frame.origin.y = self.view.frame.origin.y
        
        // Setup textfield for firstname
        firstNameField.placeholder = "First Name"
        firstNameField.borderStyle = UITextBorderStyle.roundedRect
        firstNameField.frame.size.height = 40
        firstNameField.frame.size.width = self.view.frame.size.width / 1.5
        firstNameField.center.x = self.view.center.x
        firstNameField.frame.origin.y = logoImageView.frame.size.height + 30
        
        // Setup textfield for lastname
        lastNameField.placeholder = "Surname"
        lastNameField.borderStyle = UITextBorderStyle.roundedRect
        lastNameField.frame.size.height = 40
        lastNameField.frame.size.width = self.view.frame.size.width / 1.5
        lastNameField.center.x = self.view.center.x
        lastNameField.frame.origin.y = firstNameField.frame.origin.y + 60
        
        // Setup university textfield
        universityField.placeholder = "Pick your current university"
        universityField.borderStyle = UITextBorderStyle.roundedRect
        universityField.frame.size.height = 40
        universityField.frame.size.width = self.view.frame.size.width / 1.5
        universityField.center.x = self.view.center.x
        universityField.frame.origin.y = lastNameField.frame.origin.y + 60
        
        // Setup study line textfield
        studyLineField.placeholder = "Pick your current study line"
        studyLineField.borderStyle = UITextBorderStyle.roundedRect
        studyLineField.frame.size.height = 40
        studyLineField.frame.size.width = self.view.frame.size.width / 1.5
        studyLineField.center.x = self.view.center.x
        studyLineField.frame.origin.y = universityField.frame.origin.y + 60
        
        // Setup buttons
        nextButton.backgroundColor = UIColor.white
        nextButton.setTitle("Next >", for: .normal)
        nextButton.setTitleColor(UIColor(red: 0, green: 136, blue: 234, alpha: 1.0), for: .normal)
        nextButton.layer.cornerRadius = 5
        nextButton.frame.size.height = 40
        nextButton.frame.size.width = self.view.frame.size.width / 5
        nextButton.frame.origin.x = self.view.frame.maxX - nextButton.frame.size.width - 5
        nextButton.frame.origin.y = studyLineField.frame.origin.y + 60
        nextButton.isUserInteractionEnabled = true
        nextButton.addTarget(self, action: #selector(goToNext(sender:)), for: .touchUpInside)
        
        cancelButton.backgroundColor = UIColor.white
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(UIColor.black, for: .normal)
        cancelButton.frame.size.height = 40
        cancelButton.frame.size.width = self.view.frame.size.width / 5
        cancelButton.frame.origin.x = self.view.frame.origin.x + 5
        cancelButton.frame.origin.y = nextButton.frame.origin.y
        cancelButton.isUserInteractionEnabled = true
        cancelButton.addTarget(self, action: #selector(cancelReg(sender:)), for: .touchUpInside)
        
        // Add all elements to superview
        self.view.addSubview(logoImageView)
        self.view.addSubview(firstNameField)
        self.view.addSubview(lastNameField)
        self.view.addSubview(universityField)
        self.view.addSubview(studyLineField)
        self.view.addSubview(nextButton)
        self.view.addSubview(cancelButton)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func cancelReg(sender: UIButton) {
    
        let backToLoginVC = LoginViewController()
        self.present(backToLoginVC, animated: true, completion: nil)
    
    }
    
    func goToNext(sender: UIButton) {
    
        let firstNameTyped = firstNameField.text!
        let lastNameTyped = lastNameField.text!
        let universityChosen = universityField.text!
        let studyLineChosen = studyLineField.text!
        
        if(firstNameTyped.isEmpty || lastNameTyped.isEmpty || universityChosen.isEmpty || studyLineChosen.isEmpty) {
        
            displayError(message: "No fields can be left empty!")
        
        } else {
        
            let nextVC = RegisterViewController()
            
            nextVC.firstNameHolder = firstNameTyped
            nextVC.lastNameHolder = lastNameTyped
            nextVC.universityHolder = universityChosen
            nextVC.studyLineHolder = studyLineChosen
        
            self.present(nextVC, animated: true, completion: nil)
            
        }
    
    }
    
    func displayError(message: String) {
        
        let myAlert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        myAlert.addAction(okAction)
        
        self.present(myAlert, animated: true, completion: nil)
        
    }
    

}
