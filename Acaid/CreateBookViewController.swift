//
//  CreateBookViewController.swift
//  Acaid
//
//  Created by Frederik Eriksen on 04/12/2017.
//  Copyright © 2017 Acaid. All rights reserved.
//

import UIKit
import Firebase

class CreateBookViewController: UIViewController {
    
    var toggle = UISegmentedControl()
    let titleText = UITextField()
    let descText = UITextField()
    let courseText = UITextField()
    let semesterText = UITextField()
    let price = UITextField()
    let submit = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        let navBar : UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        self.view.addSubview(navBar)
        let navItem = UINavigationItem(title: "Upload Book")
        navBar.setItems([navItem], animated: false)
        
        // Setup toggle button
        let items = ["For sale", "Book request"]
        toggle = UISegmentedControl(items: items)
        toggle.selectedSegmentIndex = 0
        toggle.backgroundColor = UIColor.white
        toggle.tintColor = UIColor(red: 0, green: 0.4118, blue: 0.5843, alpha: 1.0)
        let frame = UIScreen.main.bounds
        toggle.frame = CGRect(x: frame.minX + 20, y: navBar.frame.maxY + 20, width: frame.width - 40, height: 50)
        self.view.addSubview(toggle)
        
        // Setup title textfield
        titleText.placeholder = "Title"
        titleText.borderStyle = UITextBorderStyle.roundedRect
        titleText.frame.size.height = 50
        titleText.frame.size.width = self.view.frame.size.width / 1.4
        titleText.center.x = self.view.center.x
        titleText.frame.origin.y = toggle.frame.maxY + 30
        titleText.autocapitalizationType = UITextAutocapitalizationType.none
        self.view.addSubview(titleText)
        
        // Setup description textfield
        descText.placeholder = "Description"
        descText.borderStyle = UITextBorderStyle.roundedRect
        descText.frame.size.height = titleText.frame.size.height
        descText.frame.size.width = titleText.frame.size.width
        descText.center.x = self.view.center.x
        descText.frame.origin.y = titleText.frame.maxY + 30
        descText.autocapitalizationType = UITextAutocapitalizationType.none
        self.view.addSubview(descText)
        
        // Setup course textfield
        courseText.placeholder = "Course"
        courseText.borderStyle = UITextBorderStyle.roundedRect
        courseText.frame.size.width = descText.frame.size.width
        courseText.frame.size.height = descText.frame.size.height
        courseText.center.x = self.view.center.x
        courseText.frame.origin.y = descText.frame.maxY + 30
        courseText.autocapitalizationType = UITextAutocapitalizationType.none
        self.view.addSubview(courseText)
        
        // Setup semester textfield
        semesterText.placeholder = "Semester"
        semesterText.borderStyle = UITextBorderStyle.roundedRect
        semesterText.frame.size.width = courseText.frame.size.width
        semesterText.frame.size.height = courseText.frame.size.height
        semesterText.center.x = self.view.center.x
        semesterText.frame.origin.y = courseText.frame.maxY + 30
        semesterText.autocapitalizationType = UITextAutocapitalizationType.none
        self.view.addSubview(semesterText)
        
        // Setup price textfield
        price.placeholder = "Select a price in DKK"
        price.borderStyle = UITextBorderStyle.roundedRect
        price.frame.size.height = descText.frame.size.height
        price.frame.size.width = descText.frame.size.width
        price.center.x = self.view.center.x
        price.frame.origin.y = semesterText.frame.maxY + 30
        price.autocapitalizationType = UITextAutocapitalizationType.none
        self.view.addSubview(price)
        
        // Setup button for book submission
        submit.setTitle("Submit", for: .normal)
        submit.setTitleColor(UIColor.black, for: .normal)
        submit.backgroundColor = UIColor(red: 0, green: 0.4118, blue: 0.5843, alpha: 1.0)
        submit.frame.size.height = 50
        submit.frame.size.width = self.view.frame.size.width / 2
        submit.center.x = self.view.center.x
        submit.frame.origin.y = price.frame.maxY + 20
        submit.addTarget(self, action: #selector(submitBook(sender:)), for: .touchUpInside)
        self.view.addSubview(submit)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func submitBook(sender: UIButton) {
        // Submit book to database
        let titleOfBook = titleText.text
        let descOfBook = descText.text
        let courseOfBook = courseText.text
        let semesterOfBook = semesterText.text
        let priceOfBook = price.text
        
        if(titleOfBook?.isEmpty)! {
            self.displayError(message: "Please set a title before submission!")
        } else {
        
            if(toggle.selectedSegmentIndex == 0) {
                DBService().bookCreation(title: titleOfBook!, description: descOfBook!, course: courseOfBook!, semester: semesterOfBook!, seller: (Auth.auth().currentUser?.uid)!, price: priceOfBook! + "DKK")
                print("Book uploaded")
                self.present(TabBarController(), animated: true, completion: nil)
            } else if(toggle.selectedSegmentIndex == 1) {
                DBService().bookReq(title: titleOfBook!, initiator: (Auth.auth().currentUser?.uid)!, description: descOfBook!, course: courseOfBook!, semester: semesterOfBook!, price: priceOfBook! + "DKK")
                print("Book request uploaded")
                self.present(TabBarController(), animated: true, completion: nil)
            }
        }
    }
    
    // Error message
    func displayError(message: String) {
        
        let myAlert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        myAlert.addAction(okAction)
        
        self.present(myAlert, animated: true, completion: nil)
        
    }
    

}
