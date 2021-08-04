//
//  LoginViewController.swift
//  Group2Project
//
//  Created by Harpreet on 8/2/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    // using as a core data
    let defaults = UserDefaults.standard
    
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pw: UITextField!
    
    @IBAction func moveMain(_ sender: Any) {
        
        // get All Account Data.
        let loginAccountDic: [String: Any]  = defaults.object(forKey: "LoginAccount") as? [String: Any] ?? [:]
        
        // finding Email to Account in the dic
        let isEmail: [String: Any] = loginAccountDic[email.text ?? ""] as? [String: Any] ?? [:]
        // email validate
        if(email.text?.count == 0 || pw.text?.count == 0){
            let alert = UIAlertController(title: "Login Fail!", message: "Check the Account Info!!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }else if(isEmail.count == 0){
            let alert = UIAlertController(title: "Login Fail!", message: "It already exsits!!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }else{
            // cehck password
            let dPw = isEmail["pw"] ?? ""
            let _pw = pw.text
            if(_pw != dPw as? String ){
                let alert = UIAlertController(title: "Login Fail!", message: "Check the Password!!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
                self.present(alert, animated: true)
                return
            }
            
        }
        // Save lastLogin Id.
        defaults.setValue(email.text!, forKey: "lastLogin")
        pw.text = ""
        
        // move home Page.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "mainTab")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    // start part
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // check the last loginID
        let lastLoginId = defaults.object(forKey: "lastLogin") ?? ""
        // base setting email.
        email.text = lastLoginId as? String
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // login page doesn't need navigation bar
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
}
