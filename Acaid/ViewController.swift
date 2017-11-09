//
//  ViewController.swift
//  Acaid
//
//  Created by Frederik Eriksen on 09/10/2017.
//  Copyright © 2017 Acaid. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    let testButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        let navBar : UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        self.view.addSubview(navBar)
        let navItem = UINavigationItem(title: "Username")
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(logoutTest(sender:)))
        let search = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: #selector(searchFunc(sender:)))
        navItem.leftBarButtonItem = search
        navItem.rightBarButtonItem = button
        navBar.setItems([navItem], animated: false)

        let segItems = ["My Sessions", "Available", "Requests"]
        let toggle = UISegmentedControl(items: segItems)
        toggle.selectedSegmentIndex = 0
        let frame = UIScreen.main.bounds
        toggle.frame = CGRect(x: frame.minX - 10, y: frame.minY + navBar.frame.size.height + 10, width: frame.width - 20, height: 30)
        toggle.layer.cornerRadius = 25
        toggle.backgroundColor = UIColor.white
        toggle.tintColor = UIColor(red: 0, green: 136, blue: 234, alpha: 1.0)
        toggle.center.x = self.view.center.x
        
        self.view.addSubview(toggle)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    

    // Logout test function
    func logoutTest(sender: UIButton) {
        
        do {
            
            try Auth.auth().signOut()
            
        } catch let logoutError {
            
            print(logoutError)
            
        }
        
        let loginVC = LoginViewController()
        self.present(loginVC, animated: true, completion: nil)
        
    }
    
    // Search function
    func searchFunc(sender: UIButton) {
    
        // Search
    
    }

}

