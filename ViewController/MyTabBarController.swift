//
//  MyTabBarController.swift
//  Group2Project
//
//  Created by user197710 on 8/2/21.
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
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if(index == 1){
            let alert = UIAlertController(title: "LogOut", message: "Do you want LogOut", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                self.dismiss(animated: false, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        return index != 1
    }
}
