//
//  ProfileSettings.swift
//  Group2Project
//
//  Created by user196663 on 8/2/21.
//

import UIKit

class ProfileSettings: UIViewController {
    let defaults = UserDefaults.standard
    let emailPattern = #"^\S+@\S+\.\S+$"#
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pass1: UITextField!
    @IBOutlet weak var pass2: UITextField!
    @IBOutlet weak var pushSwich: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()

        let loginAccountDic: [String: Any]  = defaults.object(forKey: "LoginAccount") as? [String: Any] ?? [:]
        let lastLoginId = defaults.object(forKey: "lastLogin") as! String
        let isEmail: [String: Any] = loginAccountDic[lastLoginId] as? [String: Any] ?? [:]
        
        email.text = lastLoginId
        
        pushSwich.setOn(isEmail["pushagree"] as! Bool, animated: false)
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func save(_ sender: Any) {
        
        let result = email.text?.range(
            of: emailPattern,
            options: .regularExpression
        )
        
        if(email.text?.count == 0 || result == nil){
            let alert = UIAlertController(title: "Warning", message: "Check your Email!!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        if((pass1.text?.count != 0 && pass1.text?.count == 0) || pass1.text != pass2.text){
            let alert = UIAlertController(title: "Warning!", message: "Check your Password!!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        var loginAccountDic: [String: Any]  = defaults.object(forKey: "LoginAccount") as? [String: Any] ?? [:]
        let lastLoginId = defaults.object(forKey: "lastLogin") as! String
        let isEmail: [String: Any] = loginAccountDic[lastLoginId] as? [String: Any] ?? [:]
        var dPw = isEmail["pw"] ?? ""
        if(pass1.text?.count != 0){
            dPw = pass1.text!
        }
        
        loginAccountDic[email.text!] = ["pw":dPw, "pushagree":pushSwich.isOn]
        defaults.setValue(loginAccountDic, forKey: "LoginAccount")
        
        let alert = UIAlertController(title: "Success!", message: "Update Account!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in self.navigationController?.popViewController(animated: true)}))
        self.present(alert, animated: true)
        self.view.endEditing(true)
        
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
