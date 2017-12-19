//
//  CreateSessionViewController.swift
//  Acaid
//
//  Created by Frederik Eriksen on 27/11/2017.
//  Copyright © 2017 Acaid. All rights reserved.
//

import UIKit
import Firebase
import RNCryptor
import CryptoSwift

class CreateSessionViewController: UIViewController {
    
    var toggle = UISegmentedControl()
    let titleText = UITextField()
    let descriptionText = UITextField()
    let submit = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*-----------VIEW SETUP BEGIN----------*/
        self.view.backgroundColor = UIColor.white
        
        let navBar : UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        navBar.tintColor = UIColor.white
        navBar.barTintColor = UIColor(red: 0, green: 0.4118, blue: 0.5843, alpha: 1.0)
        self.view.addSubview(navBar)
        let navItem = UINavigationItem(title: "Create Session")
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(exitCreation(sender:)))
        navItem.rightBarButtonItem = button
        navBar.setItems([navItem], animated: false)
        
        let segItems = ["Facilitate Session", "Request session"]
        toggle = UISegmentedControl(items: segItems)
        toggle.selectedSegmentIndex = 0
        let frame = UIScreen.main.bounds
        toggle.frame = CGRect(x: frame.minX - 10, y: frame.minY + 10 + navBar.frame.size.height, width: frame.width - 20, height: 30)
        toggle.layer.cornerRadius = 25
        toggle.backgroundColor = UIColor.white
        toggle.tintColor = UIColor(red: 0, green: 0.4118, blue: 0.5843, alpha: 1.0)
        toggle.center.x = self.view.center.x
        self.view.addSubview(toggle)

        titleText.placeholder = "Give this session a title"
        titleText.borderStyle = UITextBorderStyle.roundedRect
        titleText.frame.size.width = self.view.frame.size.width / 1.4
        titleText.frame.size.height = 50
        titleText.center.x = self.view.center.x
        titleText.frame.origin.y = toggle.frame.origin.y + (2 * toggle.frame.size.height)
        titleText.autocapitalizationType = UITextAutocapitalizationType.none
        self.view.addSubview(titleText)
        
        descriptionText.placeholder = "Give this session a description"
        descriptionText.borderStyle = UITextBorderStyle.roundedRect
        descriptionText.frame.size.width = titleText.frame.size.width
        descriptionText.frame.size.height = titleText.frame.size.height
        descriptionText.center.x = self.view.center.x
        descriptionText.frame.origin.y = titleText.frame.origin.y + (2 * titleText.frame.size.height)
        descriptionText.autocapitalizationType = UITextAutocapitalizationType.none
        self.view.addSubview(descriptionText)
        
        submit.setTitle("Submit session", for: .normal)
        submit.setTitleColor(UIColor.black, for: .normal)
        submit.backgroundColor = UIColor(red: 0, green: 0.4118, blue: 0.5843, alpha: 1.0)
        submit.frame.size.height = 50
        submit.frame.size.width = self.view.frame.size.width / 2
        submit.center.x = self.view.center.x
        submit.frame.origin.y = descriptionText.frame.origin.y + (2 * descriptionText.frame.size.height)
        submit.isUserInteractionEnabled = true
        submit.addTarget(self, action: #selector(submitSession(sender:)), for: .touchUpInside)
        self.view.addSubview(submit)
        
        /*--------------View Setup Done----------------*/
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func submitSession(sender: UIButton) {
        let titleInput = titleText.text
        let descriptionInput = descriptionText.text
        
        let vc = TabBarController()
        
        if(titleInput?.isEmpty)! {
            displayError(message: "Every session needs a title, please provide one")
        } else if(toggle.selectedSegmentIndex == 0) {
            
            // Register session as available in database
            // 1. Check if session creator is in fact a registered tutor
            let tutorRef = Database.database().reference().child("Users").child((Auth.auth().currentUser?.uid)!)
            
            tutorRef.observe(.value, with: {(snapshot) in
                let dict = snapshot.value as? NSDictionary
                let isTutor = dict?["isTutor"] as? String ?? ""
                // 2. if the returned snapshot from Firebase contains key: isTutor with value: false, this user is not a tutor and can therefore not create a tutoring session
                if isTutor == "false" {
                    self.displayError(message: "You need to be a tutor to create this session")
                } else if isTutor == "true" {
                    // If the returned snapshot contains key: isTutor with value: true, this user is a tutor and we therefore accept the creation of a tutoring session
                    
                    let rating = dict?["rating"] as? Double
                    let nRates = dict?["nRaters"] as? Double
                    let accRate = rating! / nRates!
                        
                        DBService().createSession(title: titleInput!, description: descriptionInput!, type: "available", initiator: (Auth.auth().currentUser?.uid)!, rating: accRate, pressed: "none", status: "none")
                            self.present(vc, animated: true, completion: nil)
                    }
                })
        }
            else if(toggle.selectedSegmentIndex == 1) {
            // Register session as a request in database
            DBService().createSession(title: titleInput!, description: descriptionInput!, type: "request", initiator: (Auth.auth().currentUser?.uid)!, rating: 0, pressed: "none", status: "nome")
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func exitCreation(sender: UIButton) {
        // User cancels creation of session and we present the previous screen
        let previousVC = TabBarController()
        self.present(previousVC, animated: true, completion: nil)
    }
    
    // Fetch the rating of currentuser if tutor, so we can append it to a session
    
    func displayError(message: String) {
        
        let myAlert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        myAlert.addAction(okAction)
        
        self.present(myAlert, animated: true, completion: nil)
        
    }

}
