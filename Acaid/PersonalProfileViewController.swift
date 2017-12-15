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
    
    let profileImageView = UIImageView()
    let name = UILabel()
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
        
        // Setup imageview for profile picture
        profileImageView.backgroundColor = UIColor(red: 0, green: 0.4118, blue: 0.5843, alpha: 1.0)
        profileImageView.frame.size.height = self.view.frame.size.height / 3
        profileImageView.frame.size.width = self.view.frame.size.width
        profileImageView.center.x = self.view.center.x
        profileImageView.frame.origin.y = self.view.frame.origin.y + navBar.frame.size.height
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
        
        /*--------------View Setup Done----------------*/
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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
