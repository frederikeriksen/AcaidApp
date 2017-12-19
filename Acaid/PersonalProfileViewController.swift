//
//  PersonalProfileViewController.swift
//  Acaid
//
//  Created by Frederik Eriksen on 02/11/2017.
//  Copyright © 2017 Acaid. All rights reserved.
//

import UIKit
import Firebase
import RNCryptor
import CryptoSwift

class PersonalProfileViewController: UIViewController {
    
    let profileContentView = UIView()
    let aboutContentView = UIView()
    let profileImageView = UIImageView()
    let name = UILabel()
    let uniLabel = UILabel()
    let beTutor = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*-----------VIEW SETUP BEGIN----------*/
        self.view.backgroundColor = UIColor.white
        
        let navBar : UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        navBar.tintColor = UIColor.white
        navBar.barTintColor = UIColor(red: 0, green: 0.4118, blue: 0.5843, alpha: 1.0)
        let navItem = UINavigationItem(title: "Profile")
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
        
        // Setup profile content view
        profileContentView.frame.size.height = (self.view.frame.size.height / 2) - navBar.frame.size.height
        profileContentView.frame.size.width = self.view.frame.size.width
        profileContentView.frame.origin.y = navBar.frame.maxY
        profileContentView.frame.origin.x = self.view.frame.origin.x
        profileContentView.backgroundColor = UIColor.white
        profileContentView.layer.borderWidth = 1
        profileContentView.layer.borderColor = UIColor(red: 0, green: 0.4118, blue: 0.5843, alpha: 1.0).cgColor
        
        // Setup about content view
        aboutContentView.frame.size.height = profileContentView.frame.size.height
        aboutContentView.frame.size.width = profileContentView.frame.size.width
        aboutContentView.frame.origin.y = profileContentView.frame.maxX
        aboutContentView.frame.origin.x = self.view.frame.origin.x
        aboutContentView.backgroundColor = UIColor.white
        
        // Setup imageview for profile picture
        profileImageView.backgroundColor = UIColor(red: 0, green: 0.4118, blue: 0.5843, alpha: 1.0)
        profileImageView.frame.size.height = profileContentView.frame.size.height - 140
        profileImageView.frame.size.width = profileImageView.frame.size.height
        profileImageView.frame.origin.x = self.view.frame.origin.x + 25
        profileImageView.frame.origin.y = profileContentView.frame.origin.y + 1
        profileImageView.layer.cornerRadius = 0.5 * profileImageView.frame.size.height
        profileContentView.addSubview(profileImageView)
        
        // Setup label with student name
        name.frame.size.width = self.view.frame.size.width - profileImageView.frame.maxX
        name.frame.size.height = 35
        name.frame.origin.y = profileImageView.frame.origin.y
        name.frame.origin.x = profileImageView.frame.maxX - 30
        name.text = "Name: "
        name.textAlignment = .center
        name.font = UIFont.boldSystemFont(ofSize: 18)
        profileContentView.addSubview(name)
        
        // Setup University label
        uniLabel.frame.size.width = name.frame.size.width
        uniLabel.frame.size.height = name.frame.size.height
        uniLabel.frame.origin.y = name.frame.maxY
        uniLabel.frame.origin.x = name.frame.origin.x
        uniLabel.text = "University: "
        uniLabel.textAlignment = .center
        uniLabel.font = UIFont.boldSystemFont(ofSize: 18)
        profileContentView.addSubview(uniLabel)
        
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
        
        self.view.addSubview(profileContentView)
        
        /*--------------View Setup Done----------------*/
        
        retrieveUserInfo()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        retrieveUserInfo()
    }
    
    func retrieveUserInfo() {
        
        // Retrieve info of current user
        let queryRef = Database.database().reference().child("Users").child((Auth.auth().currentUser?.uid)!)
        queryRef.observe(.value, with: {(snapshot) in
            let dict = snapshot.value as? NSDictionary
            let fName = dict?["firstname"] as? String ?? ""
            let lName = dict?["lastname"] as? String ?? ""
            let uni = dict?["university"] as? String ?? ""
            let istut = dict?["isTutor"] as? String ?? ""
            
            // Update labels to contain users info
            self.name.text = "Name: " + fName + " " + lName
            self.uniLabel.text = "University: " + uni
            
            // Check if user is tutor. If yes, remove becomeTutor button
            if istut == "true" {
                self.beTutor.removeFromSuperview()
            }
        })
    }
    
    func becomeTutor(sender: UIButton) {
        
        // Get id of current user
        let userRef = Database.database().reference().child("Users").child((Auth.auth().currentUser?.uid)!)
        
        userRef.observe(.value, with: {(snapshot) in
            print(snapshot.key)
            let dict = snapshot.value as? NSDictionary
            let fName = dict?["firstname"] as? String ?? ""
            let lName = dict?["lastname"] as? String ?? ""
            let eMail = dict?["email"] as? String ?? ""
            let uNiversity = dict?["university"] as? String ?? ""
            let sTudyline = dict?["studyline"] as? String ?? ""
            
            let key = "gqLOHUiqQ0QjhuvI"
            let iv = "gqLOHUiqQ0QjhuvI"
            let encFname = try! fName.aesEncrypt(key: key, iv: iv)
            let encLname = try! lName.aesEncrypt(key: key, iv: iv)
            let encEmail = try! eMail.aesEncrypt(key: key, iv: iv)
            let encUni = try! uNiversity.aesEncrypt(key: key, iv: iv)
            let encStudy = try! sTudyline.aesEncrypt(key: key, iv: iv)
            userRef.setValue([
                "firstname": encFname,
                "lastname": encLname,
                "email": encEmail,
                "university": encUni,
                "studyline": encStudy,
                "isTutor": "true",
                "rating": 1 as Int,
                "nRaters": 1 as Int
                ])
            
        })
        
    }
    
}

extension String {
    func aesEncrypt(key: String, iv: String) throws -> String {
        let data = self.data(using: .utf8)!
        let encrypted = try! AES(key: key, iv: iv, blockMode: .CBC, padding: PKCS7()).encrypt([UInt8](data))
        let encryptedData = Data(encrypted)
        return encryptedData.base64EncodedString()
    }
    
}
