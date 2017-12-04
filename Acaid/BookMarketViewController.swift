//
//  BookMarketViewController.swift
//  Acaid
//
//  Created by Frederik Eriksen on 04/12/2017.
//  Copyright © 2017 Acaid. All rights reserved.
//

import UIKit
import Firebase

class BookMarketViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var toggle = UISegmentedControl()
    let postBook = UIButton()
    var booksArray = [Book]()
    var booksTable = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white

        let navBar : UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        self.view.addSubview(navBar)
        let navItem = UINavigationItem(title: "Book Market")
        navBar.setItems([navItem], animated: false)
        
        // Setup toggle button
        let items = ["Buy", "Sell"]
        toggle = UISegmentedControl(items: items)
        toggle.selectedSegmentIndex = 0
        let frame = UIScreen.main.bounds
        toggle.frame = CGRect(x: frame.minX - 20, y: navBar.frame.maxY + 10, width: frame.width - 40, height: 50)
        toggle.layer.cornerRadius = 25
        toggle.center.x = self.view.center.x
        toggle.backgroundColor = UIColor.white
        toggle.tintColor = UIColor(red: 0, green: 136, blue: 234, alpha: 1.0)
        toggle.addTarget(self, action: #selector(retrieveBooks), for: .allEvents)
        self.view.addSubview(toggle)
        
        // Setup post book button
        postBook.setTitle("+", for: .normal)
        postBook.setTitleColor(UIColor.black, for: .normal)
        postBook.backgroundColor = UIColor(red: 0.8392, green: 0.4588, blue: 0, alpha: 1)
        postBook.frame.size.width = 50
        postBook.frame.size.height = 50
        postBook.frame.origin.x = self.view.frame.maxX - 60
        postBook.frame.origin.y = self.view.frame.maxY - 120
        postBook.layer.cornerRadius = 0.5 * postBook.frame.size.width
        postBook.isUserInteractionEnabled = true
        postBook.addTarget(self, action: #selector(postBook(sender:)), for: .touchUpInside)
        self.view.addSubview(postBook)
        
        // Setup tableview in which books will be loaded
        self.booksTable.delegate = self
        self.booksTable.dataSource = self
        booksTable.register(BookCell.self, forCellReuseIdentifier: "bookCell")
        booksTable.frame.origin.x = self.view.frame.origin.x + 10
        booksTable.frame.origin.y = toggle.frame.maxY + 10
        booksTable.frame.size.height = 100
        booksTable.frame.size.width = self.view.frame.size.width - 20
        self.view.addSubview(booksTable)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        retrieveBooks()
    }
    
    func postBook(sender: UIButton) {
        // Go to book creation screen
        let bookCreationVC = CreateBookViewController()
        self.present(bookCreationVC, animated: true, completion: nil)
    }
    
    func retrieveBooks() {
        
        if(toggle.selectedSegmentIndex == 0) {
            // Retrieve books for sale
            Database.database().reference().child("Books").queryOrdered(byChild: "type").queryEqual(toValue: "sale").observe(.value, with: {(snapshot)in
                var results = [Book]()
                for book in snapshot.children {
                    results.append(Book(snapshot: book as! DataSnapshot))
                }
                self.booksArray = results.sorted(by: {(b1, b2) -> Bool in
                    b1.title > b2.title
                })
                self.booksTable.reloadData()
                print(self.booksArray)
                
            }) {(error) in
                print(error.localizedDescription)
            }
        }else if(toggle.selectedSegmentIndex == 1) {
            // Retrieve buying requests
            Database.database().reference().child("Books").queryOrdered(byChild: "type").queryEqual(toValue: "request").observe(.value, with: {(snapshot) in
                var results = [Book]()
                for book in snapshot.children {
                    results.append(Book(snapshot: book as! DataSnapshot))
                }
                self.booksArray = results.sorted(by: {(b1, b2) -> Bool in
                    b1.title > b2.title
                })
                self.booksTable.reloadData()
                print(self.booksArray)
            }) {(error) in
                print(error.localizedDescription)
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return booksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = booksTable.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as! BookCell
        
        cell.configureCell(book: booksArray[indexPath.row])
        booksTable.frame.size.height = CGFloat(booksArray.count) * CGFloat(cell.frame.size.height)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Did select this row")
    }
 

}
