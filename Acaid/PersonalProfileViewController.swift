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
    let name = UILabel()
    let beTutor = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        let navBar : UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        let navItem = UINavigationItem(title: "Profile")
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
        
        // Setup imageview for profile picture
        profileImageView.backgroundColor = UIColor(red: 0, green: 0.4118, blue: 0.5843, alpha: 1.0)
        profileImageView.frame.size.height = self.view.frame.size.height / 3
        profileImageView.frame.size.width = self.view.frame.size.width
        profileImageView.center.x = self.view.center.x
        profileImageView.frame.origin.y = self.view.frame.origin.y
        profileImageView.image = UIImage(named: "defaultPic")
        self.view.addSubview(profileImageView)
        
        // Setup label with student name
        name.frame.size.width = self.view.frame.size.width
        name.frame.size.height = 40
        name.frame.origin.y = profileImageView.frame.maxY
        name.center.x = self.view.center.x
        name.text = ""
        name.textAlignment = .center
        name.font = UIFont.boldSystemFont(ofSize: 18)
        self.view.addSubview(name)
        
        // Setup button to become tutor
        beTutor.frame.size.width = self.view.frame.size.width / 2
        beTutor.frame.size.height = 50
        beTutor.frame.origin.y = self.view.frame.maxY - 200
        beTutor.center.x = self.view.center.x
        beTutor.setTitle("Become Tutor", for: .normal)
        beTutor.setTitleColor(UIColor.black, for: .normal)
        beTutor.backgroundColor = UIColor(red: 0, green: 0.4118, blue: 0.5843, alpha: 1.0)
        beTutor.addTarget(self, action: #selector(becomeTutor(sender:)), for: .touchUpInside)
        self.view.addSubview(beTutor)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func becomeTutor(sender: UIButton) {
        
        // Get id of current user
        let curUID = Auth.auth().currentUser?.uid
        let userRef = Database.database().reference().child("Users")
        
        userRef.queryOrdered(byChild: "uid").queryEqual(toValue: curUID!).observe(.value, with: {(snapshot) in
            let removeRef = Database.database().reference().child("Users")
            let dict = snapshot.value as? NSDictionary
            let newRef = Database.database().reference().child("Tutors")
            newRef.childByAutoId().setValue([
                "firstname": dict?["firstname"] as? String ?? "",
                "lastname": dict?["lastname"] as? String ?? "",
                "email": dict?["email"] as? String ?? "",
                "university": dict?["university"] as? String ?? "",
                "studyline": dict?["studyline"] as? String ?? "",
                "rating": 0 as Int,
                "nRaters": 0 as Int
                ])
            let nodeToRemove = removeRef.child(snapshot.key)
            nodeToRemove.removeValue()
            
            })
        
    }
    
    

}
