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
        firstVC.tabBarItem.title = "Home"
        
        let secondVC = CalendarViewController()
        secondVC.tabBarItem.title = "Calendar"
        
        let thirdVC = ChatViewController()
        thirdVC.tabBarItem.title = "Chat"
        
        let fourthVC = BookMarketViewController()
        fourthVC.tabBarItem.title = "Market"
        
        let fifthVC = PersonalProfileViewController()
        fifthVC.tabBarItem.title = "Profile"
        
        let tabBarList = [firstVC, secondVC, thirdVC, fourthVC, fifthVC]
        
        tabBar.barTintColor = UIColor(red: 0, green: 0.4118, blue: 0.5843, alpha: 1.0)
        tabBar.tintColor = UIColor.white
        
        viewControllers = tabBarList
        
        viewControllers = tabBarList
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    

}
