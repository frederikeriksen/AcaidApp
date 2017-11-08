//
//  PersonalProfileViewController.swift
//  Acaid
//
//  Created by Frederik Eriksen on 02/11/2017.
//  Copyright © 2017 Acaid. All rights reserved.
//

import UIKit
import Firebase

class PersonalProfileViewController: UIViewController {
    
    let profileImageView = UIImageView()
    let profileImage = UIImage()
    let name = UILabel()
    let initiateChatButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        let navBar : UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        let navItem = UINavigationItem(title: "Profile")
        navBar.setItems([navItem], animated: false)
        
        //Setup imageview and image for profile picture
        profileImageView.backgroundColor = UIColor.green
        profileImageView.image = profileImage
        profileImageView.frame.size.height = self.view.frame.size.height / 3
        profileImageView.frame.size.width = self.view.frame.size.width
        profileImageView.center.x = self.view.center.x
        profileImageView.frame.origin.y = self.view.frame.origin.y + navBar.frame.size.height
        
        // Setup name label
        name.backgroundColor = UIColor.green
        name.text = "Firstname Lastname" /* Change this to take the username of that profile's owner */
        name.textAlignment = .center
        name.font = UIFont.boldSystemFont(ofSize: 16)
        name.textColor = UIColor.white
        name.frame.size.height = 40
        name.frame.size.width = self.view.frame.size.width / 2
        name.center.x = self.view.center.x
        name.frame.origin.y = (profileImageView.frame.size.height + navBar.frame.size.height) - name.frame.size.height - 1
        
        // Setup button for starting a chat with the user
        initiateChatButton.backgroundColor = UIColor.orange
        initiateChatButton.setTitle("+", for: .normal)
        initiateChatButton.setTitleColor(UIColor.white, for: .normal)
        initiateChatButton.frame.size.height = 50
        initiateChatButton.frame.size.width = 50
        initiateChatButton.frame.origin.x = self.view.frame.maxX - 60
        initiateChatButton.frame.origin.y = profileImageView.frame.size.height + navBar.frame.size.height
        initiateChatButton.layer.cornerRadius = 0.5 * initiateChatButton.frame.size.width
        initiateChatButton.clipsToBounds = true
        
        
        // Add all elements to the superview
        self.view.addSubview(navBar)
        self.view.addSubview(profileImageView)
        self.view.addSubview(name)
        self.view.addSubview(initiateChatButton)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    

}
