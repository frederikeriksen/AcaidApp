//
//  PresentingViewController.swift
//  Acaid
//
//  Created by Frederik Eriksen on 03/11/2017.
//  Copyright © 2017 Acaid. All rights reserved.
//

import UIKit
import Firebase

class PresentingViewController: UIViewController {
    
    let loadingText = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()

        /*-----------VIEW SETUP BEGIN----------*/
        self.view.backgroundColor = UIColor(red: 0, green: 0.4118, blue: 0.5843, alpha: 1.0)
        
        loadingText.text = "Loading..."
        loadingText.font = UIFont.boldSystemFont(ofSize: 20)
        loadingText.backgroundColor = UIColor(red: 0, green: 0.4118, blue: 0.5843, alpha: 1.0)
        loadingText.textColor = UIColor.white
        loadingText.textAlignment = .center
        loadingText.frame.size.height = 100
        loadingText.frame.size.width = self.view.frame.size.width
        loadingText.center.x = self.view.center.x
        loadingText.center.y = self.view.center.y
        
        self.view.addSubview(loadingText)
        
        /*--------------View Setup Done----------------*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let delay = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: delay) {
        self.checkLoggedInUser()
        }
    }
    
    func checkLoggedInUser() {
        
        if Auth.auth().currentUser?.uid == nil {
            
            handleLogout()
            
        } else {
            
            print("User is logged in")
            let homeVC = TabBarController()
            self.present(homeVC, animated: true, completion: nil)
            var window: UIWindow?
            window = UIWindow(frame: UIScreen.main.bounds)
            window!.rootViewController = homeVC
            
        }
        
    }
    
    func handleLogout() {
        
        do {
            
            try Auth.auth().signOut()
            
        } catch let logoutError {
            
            print(logoutError)
            
        }
        
        let loginVC = LoginViewController()
        self.present(loginVC, animated: true, completion: nil)
        var window: UIWindow?
        window = UIWindow(frame: UIScreen.main.bounds)
        self.view.window!.rootViewController = loginVC
    }
    

}
