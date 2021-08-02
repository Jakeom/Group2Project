//
//  LoginViewController.swift
//  Group2Project
//
//  Created by user197710 on 8/2/21.
//

import UIKit

class LoginViewController: UIViewController {

    let defaults = UserDefaults.standard
    
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pw: UITextField!

    @IBAction func moveMain(_ sender: Any) {
        
        let loginAccountDic: [String: Any]  = defaults.object(forKey: "LoginAccount") as? [String: Any] ?? [:]
        
        let isEmail: [String: Any] = loginAccountDic[email.text ?? ""] as? [String: Any] ?? [:	]
        if(email.text?.count == 0 || pw.text?.count == 0){
            let alert = UIAlertController(title: "Warning", message: "Check the Account Info!!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }else if(isEmail.count == 0){
            let alert = UIAlertController(title: "Warning", message: "It already exsits!!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }else{
            
            let dPw = isEmail["pw"] ?? ""
            let _pw = pw.text
            if(_pw != dPw as? String ){
                let alert = UIAlertController(title: "Warning", message: "Check the Password!!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
                self.present(alert, animated: true)
                return
            }
            
        }
        
        defaults.setValue(email.text!, forKey: "lastLogin")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "mainTab")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let lastLoginId = defaults.object(forKey: "lastLogin") ?? ""
        email.text = lastLoginId as? String
        
        // Do any additional setup after loading the view.
    }


}
