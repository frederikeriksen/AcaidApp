//
//  SessionViewController.swift
//  Acaid
//
//  Created by Frederik Eriksen on 07/12/2017.
//  Copyright © 2017 Acaid. All rights reserved.
//

import UIKit
import Firebase

class SessionViewController: UIViewController {
    
    var user: User?
    var ses: Session?
    
    let imageView = UIImageView()
    let name = UILabel()
    let accept = UIButton()
    let deny = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        /*-----------UI SETUP---------*/
        
        self.view.backgroundColor = UIColor.white
        
        // Setup imageview for profilepic
        imageView.backgroundColor = UIColor(red: 0, green: 0.4118, blue: 0.5843, alpha: 1.0)
        imageView.frame.size.height = 200
        imageView.frame.size.width = imageView.frame.size.height
        imageView.center.x = self.view.center.x
        imageView.frame.origin.y = self.view.frame.origin.y + 70
        imageView.layer.cornerRadius = 0.5 * imageView.frame.size.height
        self.view.addSubview(imageView)
        
        // Setup name label with user's name
        name.frame.size.width = self.view.frame.size.width
        name.frame.size.height = 35
        name.frame.origin.y = imageView.frame.maxY + 20
        name.center.x = self.view.center.x
        name.text = ""
        name.textAlignment = .center
        name.font = UIFont.boldSystemFont(ofSize: 18)
        self.view.addSubview(name)
        
        // Setup accept button
        accept.frame.size.width = self.view.frame.size.width / 2.5
        accept.frame.size.height = 50
        accept.frame.origin.y = name.frame.maxY + 100
        accept.frame.origin.x = self.view.frame.origin.x + 20
        accept.setTitle("Accept", for: .normal)
        accept.backgroundColor = UIColor.green
        accept.setTitleColor(UIColor.white, for: .normal)
        self.view.addSubview(accept)
        
        // Setup decline button
        deny.frame.size.width = accept.frame.size.width
        deny.frame.size.height = accept.frame.size.height
        deny.frame.origin.y = accept.frame.origin.y
        deny.frame.origin.x = self.view.frame.maxX - deny.frame.size.width - 20
        deny.setTitle("Decline", for: .normal)
        deny.setTitleColor(UIColor.white, for: .normal)
        deny.backgroundColor = UIColor.red
        self.view.addSubview(deny)
        
        /*-----------UI SETUP DONE-----*/
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        retrieveRequesterInfo()
        print(ses?.key)
        print(user?.key)
        accept.addTarget(self, action: #selector(accept(sender:)), for: .touchUpInside)
        deny.addTarget(self, action: #selector(deline(sender:)), for: .touchUpInside)
    }
    
    func retrieveRequesterInfo() {
        // name.text = (user?.firstName)! + " " + (user?.lastName)!
    }
    
    func accept(sender: UIButton) {
        let sessionsId = ses?.key
        Database.database().reference().child("Sessions").child(sessionsId!).updateChildValues(["status": "active"])
        let back = TabBarController()
        self.present(back, animated: true, completion: nil)
    }
    
    func deline(sender: UIButton) {
        let sessionId = ses?.key
        Database.database().reference().child("Sessions").child(sessionId!).updateChildValues(["pressedBy": "none"])
        let back = TabBarController()
        self.present(back, animated: true, completion: nil)
    }
}
