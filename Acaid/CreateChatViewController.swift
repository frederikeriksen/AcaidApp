//
//  CreateChatViewController.swift
//  Acaid
//
//  Created by Frederik Eriksen on 05/12/2017.
//  Copyright © 2017 Acaid. All rights reserved.
//

import UIKit
import Firebase

class CreateChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let searchBar = UISearchBar()
    let userTable = UITableView()
    var usersArray = [User]()
    var selectedUser = User?.self

    override func viewDidLoad() {
        super.viewDidLoad()

        /*-----------VIEW SETUP BEGIN----------*/
        self.view.backgroundColor = UIColor.white
        
        let navBar : UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        navBar.tintColor = UIColor.white
        navBar.barTintColor = UIColor(red: 0, green: 0.4118, blue: 0.5843, alpha: 1.0)
        self.view.addSubview(navBar)
        let navItem = UINavigationItem(title: "Start Chat")
        let backButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(goBack(sender:)))
        navBar.setItems([navItem], animated: false)
        navItem.leftBarButtonItem = backButton
        
        // Setup searchbar for user input
        searchBar.placeholder = "Search"
        searchBar.autocapitalizationType = UITextAutocapitalizationType.none
        searchBar.frame.size.height = 30
        searchBar.frame.size.width = self.view.frame.size.width
        searchBar.frame.origin.y = navBar.frame.maxY
        searchBar.center.x = self.view.center.x
        self.view.addSubview(searchBar)
        
        // Setup usertableview to load users
        self.userTable.delegate = self
        self.userTable.dataSource = self
        userTable.register(UserCell.self, forCellReuseIdentifier: "userCell")
        userTable.frame.origin.y = searchBar.frame.maxY + 10
        userTable.frame.origin.x = self.view.frame.origin.x + 10
        userTable.frame.size.width = self.view.frame.size.width - 20
        userTable.frame.size.height = 100
        self.view.addSubview(userTable)
        
        /*--------------View Setup Done----------------*/
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Retrieve users of the app to a tableview
        retrieveUsers()
    }
    
    func goBack(sender: UIButton) {
        let previousVC = TabBarController()
        self.present(previousVC, animated: true, completion: nil)
    }
    
    func retrieveUsers() {
        // Retrieve users from database available to chat and store in array
        let userRef = Database.database().reference().child("Users")
        userRef.observe(.value, with: {(snapshot) in
            var results = [User]()
            for user in snapshot.children {
                results.append(User(snapshot: user as! DataSnapshot))
            }
            self.usersArray = results.sorted(by: {(u1, u2) -> Bool in
                u1.firstName < u2.firstName
            })
            // reloads tableview with array data
            self.userTable.reloadData()
            print(self.usersArray)
        }) {(error) in
            print(error.localizedDescription)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Returns number of rows in array
        return usersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Fetching cell used to display each user
        let cell = userTable.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserCell
        
        cell.configureCell(user: usersArray[indexPath.row])
        userTable.frame.size.height = CGFloat(usersArray.count) * CGFloat(cell.frame.size.height)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Keep track of which cell was selected
        let index = userTable.indexPathForSelectedRow
        let chatUser = usersArray[indexPath.row]
        let thisCell = userTable.cellForRow(at: index!) as UITableViewCell!
        let nextVC = ActiveChatViewController()
        nextVC.user = chatUser
        self.present(nextVC, animated: true, completion: nil)
    }
    
    func searchFunction() {
        // Implement search
    }

}
