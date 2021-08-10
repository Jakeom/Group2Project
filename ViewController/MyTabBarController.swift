//
//  MyTabBarController.swift
//  Group2Project
//
//  Created by Younghyun Eom on 8/2/21.
//

import UIKit

class MyTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
      
    }
    
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if(item.title == "LogOut") {
            index = 1
        }else {
            index = 0
        }
        
    }
    
    // logout Controll if index 1 it is clicked logOut item 
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if(index == 1){
            let alert = UIAlertController(title: "LogOut", message: "Are you sure?  ", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Logout", style: .default, handler: { action in
                self.dismiss(animated: false, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        return index != 1
    }
}
