//
//  CreateSessionViewController.swift
//  Acaid
//
//  Created by Frederik Eriksen on 27/11/2017.
//  Copyright © 2017 Acaid. All rights reserved.
//

import UIKit
import Firebase

class CreateSessionViewController: UIViewController {
    
    var toggle = UISegmentedControl()
    let titleText = UITextField()
    let descriptionText = UITextField()
    let submit = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        let navBar : UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
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
        toggle.tintColor = UIColor(red: 0, green: 136, blue: 234, alpha: 1.0)
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
        submit.backgroundColor = UIColor(red: 0, green: 136, blue: 234, alpha: 1.0)
        submit.frame.size.height = 50
        submit.frame.size.width = self.view.frame.size.width / 2
        submit.center.x = self.view.center.x
        submit.frame.origin.y = descriptionText.frame.origin.y + (2 * descriptionText.frame.size.height)
        submit.isUserInteractionEnabled = true
        submit.addTarget(self, action: #selector(submitSession(sender:)), for: .touchUpInside)
        self.view.addSubview(submit)
        
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
            DBService().createSession(title: titleInput!, description: descriptionInput!, type: "available", initiator: (Auth.auth().currentUser?.uid)!)
            self.present(vc, animated: true, completion: nil)
            
        } else if(toggle.selectedSegmentIndex == 1) {
            // Register session as a request in database
            DBService().createSession(title: titleInput!, description: descriptionInput!, type: "request", initiator: (Auth.auth().currentUser?.uid)!)
            self.present(vc, animated: true, completion: nil)
            
        }
    }
    
    func exitCreation(sender: UIButton) {
        let previousVC = ViewController()
        self.present(previousVC, animated: true, completion: nil)
    }
    
    func displayError(message: String) {
        
        let myAlert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        myAlert.addAction(okAction)
        
        self.present(myAlert, animated: true, completion: nil)
        
    }

}
