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
        thirdVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        
        let fourthVC = BookMarketViewController()
        fourthVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 3)
        
        let tabBarList = [firstVC, secondVC, thirdVC, fourthVC]
        
        tabBar.barTintColor = UIColor(red: 0, green: 0.4118, blue: 0.5843, alpha: 1.0)
        tabBar.tintColor = UIColor.white
        
        viewControllers = tabBarList
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    

}
