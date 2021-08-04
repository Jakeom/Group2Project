//
//  ProfileSettings.swift
//  Group2Project
//
//  Created by Younghyun Eom on 8/2/21.
//

import UIKit

class ProfileSettings: UIViewController {
    // Define UserDefaults
    let defaults = UserDefaults.standard
    // Regular expression of Email.
    let emailPattern = #"^\S+@\S+\.\S+$"#
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pass1: UITextField!
    @IBOutlet weak var pass2: UITextField!
    @IBOutlet weak var pushSwich: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load User Data
        let loginAccountDic: [String: Any]  = defaults.object(forKey: "LoginAccount") as? [String: Any] ?? [:]
        let lastLoginId = defaults.object(forKey: "lastLogin") as! String
        let isEmail: [String: Any] = loginAccountDic[lastLoginId] as? [String: Any] ?? [:]
        
        // setting email text
        email.text = lastLoginId
        
        // setting push-agreement Swich
        pushSwich.setOn(isEmail["pushagree"] as! Bool, animated: false)
        
    }
    
    // key board down
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    // Updating User Account
    @IBAction func save(_ sender: Any) {
        
        // validate
        // Check email form
        let result = email.text?.range(
            of: emailPattern,
            options: .regularExpression
        )
        
        // incorrect show alret
        if(email.text?.count == 0 || result == nil){
            let alert = UIAlertController(title: "Warning", message: "Check your Email!!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        // Check Password
        if((pass1.text?.count != 0 && pass1.text?.count == 0) || pass1.text != pass2.text){
            let alert = UIAlertController(title: "Warning!", message: "Check your Password!!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        // Save Account Data
        var loginAccountDic: [String: Any]  = defaults.object(forKey: "LoginAccount") as? [String: Any] ?? [:]
        let lastLoginId = defaults.object(forKey: "lastLogin") as! String
        let isEmail: [String: Any] = loginAccountDic[lastLoginId] as? [String: Any] ?? [:]
        var dPw = isEmail["pw"] ?? ""
        if(pass1.text?.count != 0){
            dPw = pass1.text!
        }
        
        loginAccountDic[email.text!] = ["pw":dPw, "pushagree":pushSwich.isOn]
        defaults.setValue(loginAccountDic, forKey: "LoginAccount")
        
        // Alert Success message
        let alert = UIAlertController(title: "Success!", message: "Update Account!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in self.navigationController?.popViewController(animated: true)}))
        self.present(alert, animated: true)
        self.view.endEditing(true)
        
        // Reset Data
        pass1.text = ""
        pass2.text = ""
     
        
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
