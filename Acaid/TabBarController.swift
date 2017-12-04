//
//  TabBarController.swift
//  Acaid
//
//  Created by Frederik Eriksen on 30/10/2017.
//  Copyright © 2017 Acaid. All rights reserved.
//

import UIKit
import Firebase

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let firstVC = ViewController()
        firstVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        
        let secondVC = ChatViewController()
        secondVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        
        let thirdVC = PersonalProfileViewController()
        thirdVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 2)
        
        let fourthVC = BookMarketViewController()
        fourthVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 3)
        
        let tabBarList = [firstVC, secondVC, thirdVC, fourthVC]
        
        viewControllers = tabBarList
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    

}
