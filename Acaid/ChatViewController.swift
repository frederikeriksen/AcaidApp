//
//  ChatViewController.swift
//  Acaid
//
//  Created by Frederik Eriksen on 02/11/2017.
//  Copyright © 2017 Acaid. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController{ //UITableViewDelegate, UITableViewDataSource {
    
    let searchBar = UISearchBar()
    let chatTable = UITableView()
    var chatsArray = [Message]()

    override func viewDidLoad() {
        super.viewDidLoad()

        /*-----------VIEW SETUP BEGIN----------*/
        self.view.backgroundColor = UIColor.white
        
        
        let navBar : UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        navBar.tintColor = UIColor.white
        navBar.barTintColor = UIColor(red: 0, green: 0.4118, blue: 0.5843, alpha: 1.0)
        self.view.addSubview(navBar)
        let navItem = UINavigationItem(title: "Chats")
        navBar.setItems([navItem], animated: false)
        let composeButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.compose, target: self, action: #selector(createChat(sender:)))
        navItem.rightBarButtonItem = composeButton
        
        // Setup a searchbar UI
        searchBar.placeholder = "Search"
        searchBar.autocapitalizationType = UITextAutocapitalizationType.none
        searchBar.frame.size.height = 30
        searchBar.frame.size.width = self.view.frame.size.width
        searchBar.center.x = self.view.center.x
        searchBar.frame.origin.y = navBar.frame.maxY
        self.view.addSubview(searchBar)
        
        // Setup tableview to display ongoing chats
       // self.chatTable.delegate = self
        //self.chatTable.dataSource = self
        // booksTable.register(BookCell.self, forCellReuseIdentifier: "bookCell")
        chatTable.frame.origin.x = self.view.frame.origin.x + 10
        chatTable.frame.origin.y = searchBar.frame.maxY + 10
        chatTable.frame.size.height = 100
        chatTable.frame.size.width = self.view.frame.size.width - 20
        self.view.addSubview(chatTable)
        
        /*--------------View Setup Done----------------*/
        
        retrieveChats()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    func createChat(sender: UIButton) {
        let nextVC = CreateChatViewController()
        self.present(nextVC, animated: true, completion: nil)
    }
    
    func retrieveChats() {
        
        var results = [Message]()
        
        let messagesRef = Database.database().reference().child("Messages")
        messagesRef.queryOrdered(byChild: "senderId").queryEqual(toValue: Auth.auth().currentUser?.uid).observe(.value, with: {(snapshot) in
            for message in snapshot.children {
                results.append(Message(snapshot: message as! DataSnapshot))
            }
        })
        messagesRef.queryOrdered(byChild: "receiverId").queryEqual(toValue: Auth.auth().currentUser?.uid).observe(.value, with: {(snapshot) in
            for message in snapshot.children {
                results.append(Message(snapshot: message as! DataSnapshot))
            }
        })
        self.chatsArray = results.sorted(by: {(c1, c2) -> Bool in
            c1.content < c2.content
        })
        print(self.chatsArray)
    }
    
    /*func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // HI
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // HI
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // HI
    }*/
    
    func searchFunction() {
        // Implement search
    }

}
