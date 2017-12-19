//
//  ViewController.swift
//  Acaid
//
//  Created by Frederik Eriksen on 09/10/2017.
//  Copyright © 2017 Acaid. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let testButton = UIButton()
    let createSession = UIButton()
    var toggle = UISegmentedControl()
    var sessionsArray = [Session]()
    let sesTable = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*-----------VIEW SETUP BEGIN----------*/
        self.view.backgroundColor = UIColor.white
        
        let navBar : UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        navBar.barTintColor = UIColor(red: 0, green: 0.4118, blue: 0.5843, alpha: 1.0)
        self.view.addSubview(navBar)
        let navItem = UINavigationItem(title: "Your Sessions")
        navItem.titleView?.tintColor = UIColor.white
        navBar.tintColor = UIColor.white
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(logoutTest(sender:)))
        let search = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: #selector(searchFunc(sender:)))
        navItem.leftBarButtonItem = search
        navItem.rightBarButtonItem = button
        navBar.setItems([navItem], animated: false)

        // Setup toggle button
        let segItems = ["My Sessions", "Available", "Requests"]
        toggle = UISegmentedControl(items: segItems)
        toggle.selectedSegmentIndex = 0
        let frame = UIScreen.main.bounds
        toggle.frame = CGRect(x: frame.minX - 10, y: frame.minY + navBar.frame.size.height + 10, width: frame.width - 20, height: 30)
        toggle.layer.cornerRadius = 25
        toggle.backgroundColor = UIColor.white
        toggle.tintColor = UIColor(red: 0, green: 0.4118, blue: 0.5843, alpha: 1.0)
        toggle.center.x = self.view.center.x
        toggle.addTarget(self, action: #selector(retrieveSessions), for: .allEvents)
        
        self.view.addSubview(toggle)
        
        // Create session button
        createSession.setTitle("+", for: .normal)
        createSession.setTitleColor(UIColor.black, for: .normal)
        createSession.backgroundColor = UIColor(red: 0.8392, green: 0.4588, blue: 0, alpha: 1)
        createSession.frame.size.width = 50
        createSession.frame.size.height = 50
        createSession.frame.origin.x = self.view.frame.maxX - 60
        createSession.frame.origin.y = self.view.frame.maxY - 120
        createSession.layer.cornerRadius = 0.5 * createSession.frame.size.width
        createSession.isUserInteractionEnabled = true
        createSession.addTarget(self, action: #selector(createSes(sender:)), for: .touchUpInside)
        
        self.view.addSubview(createSession)
        
        self.sesTable.delegate = self
        self.sesTable.dataSource = self
        
        sesTable.register(SessionCell.self, forCellReuseIdentifier: "sessionCell")
        sesTable.frame.origin.y = toggle.frame.maxY + 50
        sesTable.frame.origin.x = self.view.frame.origin.x + 10
        sesTable.frame.size.height = self.view.frame.size.height
        sesTable.frame.size.width = self.view.frame.size.width - 20
        sesTable.rowHeight = 100
        self.view.addSubview(sesTable)
        
        /*--------------View Setup Done----------------*/
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Retrieving users sessions at toggle index 0 (users own sessions)
        retrieveSessions()
        
    }
    
    // Retrieve sessions function
    func retrieveSessions() {
        
        let sessionRef = Database.database().reference().child("Sessions")
        
        if(toggle.selectedSegmentIndex == 0) {
            // Retrieve users own sessions and append to array
            let queryRef = sessionRef.queryOrdered(byChild: "initiator").queryEqual(toValue: Auth.auth().currentUser?.uid)
            queryRef.observe(.value, with: {(snapshot) in
                var results = [Session]()
                for session in snapshot.children {
                    
                    results.append(Session(snapshot: session as! DataSnapshot))
                }
                self.sessionsArray = results.sorted(by: {(s1, s2) -> Bool in
                    s1.title < s2.title
                })
                // reload tableview with sessions
                self.sesTable.reloadData()
                print(self.sessionsArray)
              
            }) {(error) in
                print(error.localizedDescription)
            }
        
        } else if(toggle.selectedSegmentIndex == 1) {
            // Retrieve available sessions and append to array
            let availableRef = sessionRef.queryOrdered(byChild: "type").queryEqual(toValue: "available")
            availableRef.observe(.value, with: {(snapshot) in
                var results = [Session]()
                for session in snapshot.children {
                    
                    results.append(Session(snapshot: session as! DataSnapshot))
                }
                self.sessionsArray = results.sorted(by: {(s1, s2) -> Bool in
                    s1.title < s2.title
                })
                // Reloads tableview with sessions from array
                self.sesTable.reloadData()
                print(self.sessionsArray)
            }) {(error) in
                print(error.localizedDescription)
            }
            
        } else if(toggle.selectedSegmentIndex == 2) {
            // Retrieve requested sessions and append to array
            let requestRef = sessionRef.queryOrdered(byChild: "type").queryEqual(toValue: "request")
            requestRef.observe(.value, with: {(snapshot) in
                var results = [Session]()
                for session in snapshot.children {
                    
                    results.append(Session(snapshot: session as! DataSnapshot))
                }
                self.sessionsArray = results.sorted(by: {(s1, s2) -> Bool in
                    s1.title < s2.title
                })
                // Reloads tableview with array data
                self.sesTable.reloadData()
                print(self.sessionsArray)
            }) {(error) in
                print(error.localizedDescription)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Tracking number of array items
        return sessionsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Fetching cell in which each session is displayed
        let cell = sesTable.dequeueReusableCell(withIdentifier: "sessionCell", for: indexPath) as! SessionCell
        
        cell.configureCell(session: sessionsArray[indexPath.row])
        sesTable.frame.size.height = CGFloat(sessionsArray.count) * CGFloat(cell.frame.size.height)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Tracking which cell was pressed and adding a value of 'pressedBy' to indicate who pressed said cell
        let userUID = Auth.auth().currentUser?.uid
        let index = sessionsArray[indexPath.row]
        let sessionID = index.key
        let sessionTitle = index.title
        let sessionDesc = index.desc
        let sessionType = index.type
        let sessionRating = index.tutorRating
        let initiator = index.creator
        let pressed = index.pressedBy
        let status = index.wasAccepted
        if(initiator == userUID) {
            if pressed == "none" {
                displayError(message: "You cannot attend your own session")
            } else if pressed != "none" && pressed != userUID {
                    let nextVC = SessionViewController()
                    let hi = index
                    nextVC.ses = hi
                    Database.database().reference().child("Users").child(pressed).observe(.value, with: {(snapshot) in
                        print(snapshot)
                        let thisUser = User.init(snapshot: snapshot)
                        nextVC.user = thisUser
                        
                        self.present(nextVC, animated: true, completion: nil)
                    })
            }
        } else {
            if pressed == "none" {
                let thisRef = Database.database().reference().child("Sessions").child(sessionID)
                thisRef.setValue([
                    "title": sessionTitle,
                    "description": sessionDesc,
                    "type": sessionType,
                    "rating": sessionRating,
                    "initiator": initiator,
                    "status": status,
                    "pressedBy": userUID!
                    ])
                print("You selected this row")
            }
        }
    }
    
    // Go to create session screen
    func createSes(sender: UIButton) {
        let nextVC = CreateSessionViewController()
        self.present(nextVC, animated: true, completion: nil)
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
        var window: UIWindow?
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = loginVC
        
    }
    
    // Search function
    func searchFunc(sender: UIButton) {
    
        // Search
    
    }
    
    func displayError(message: String) {
        
        let myAlert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        myAlert.addAction(okAction)
        
        self.present(myAlert, animated: true, completion: nil)
        
    }

}

