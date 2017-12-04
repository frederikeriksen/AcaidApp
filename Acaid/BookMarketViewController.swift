//
//  BookMarketViewController.swift
//  Acaid
//
//  Created by Frederik Eriksen on 04/12/2017.
//  Copyright © 2017 Acaid. All rights reserved.
//

import UIKit

class BookMarketViewController: UIViewController {
    
    var toggle = UISegmentedControl()
    let postBook = UIButton()

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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func postBook(sender: UIButton) {
        // Go to book creation screen
        let bookCreationVC = CreateBookViewController()
        self.present(bookCreationVC, animated: true, completion: nil)
    }
    
    func retrieveBooks() {
        
        if(toggle.selectedSegmentIndex == 0) {
            // Retrieve books for sale
        }else if(toggle.selectedSegmentIndex == 1) {
            // Retrieve buying requests
        }
        
    }
 

}
