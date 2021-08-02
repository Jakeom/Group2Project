//
//  LogOut.swift
//  Group2Project
//
//  Created by user196663 on 8/2/21.
//

import UIKit

class LogOut: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.popViewController(animated: true)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
