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
    let university = UILabel()
    let studyLine = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        let navBar : UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        let navItem = UINavigationItem(title: "Profile")
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
        
        profileImageView.frame.size.height = self.view.frame.size.height / 3
        profileImageView.frame.size.width = self.view.frame.size.width / 1.5
        profileImageView.frame.origin.y = navBar.frame.maxY + 20
        profileImageView.center.x = self.view.center.x
        profileImageView.backgroundColor = UIColor.gray
        profileImageView.layer.cornerRadius = 0.5 * profileImageView.frame.size.width
        self.view.addSubview(profileImageView)
        
        name.frame.size.height = 50
        name.frame.size.width = self.view.frame.size.width
        name.center.x = self.view.center.x
        name.frame.origin.y = profileImageView.frame.maxY + 10
        name.textAlignment = .center
        name.font = UIFont.boldSystemFont(ofSize: 20)
        self.view.addSubview(name)
        
        university.frame.size.height = 50
        university.frame.size.width = self.view.frame.size.width
        university.center.x = self.view.center.x
        university.frame.origin.y = name.frame.maxY + 20
        university.textAlignment = .center
        university.font = UIFont.boldSystemFont(ofSize: 18)
        self.view.addSubview(university)
        
        studyLine.frame.size.height = 40
        studyLine.frame.size.width = self.view.frame.size.width
        studyLine.center.x = self.view.center.x
        studyLine.frame.origin.y = university.frame.maxY
        studyLine.textAlignment = .center
        studyLine.font = UIFont.italicSystemFont(ofSize: 14)
        self.view.addSubview(studyLine)
        
        configureProfile()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func configureProfile() {
        let userUID = Auth.auth().currentUser?.uid
        
        let queryRef = Database.database().reference().child("Users").child(userUID!)
        
        queryRef.observeSingleEvent(of: .value, with: {(snapshot) in
            let thisUser = User(snapshot: snapshot)
            self.name.text = thisUser.firstName + " " + thisUser.lastName
            self.university.text = thisUser.university
            self.studyLine.text = thisUser.studyLine
        })
        
    }

}
