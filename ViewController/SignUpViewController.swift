//
//  SignUpViewController.swift
//  Group2Project
//
//  Created by user197710 on 8/2/21.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    let emailPattern = #"^\S+@\S+\.\S+$"#
    
    @IBOutlet weak var pushAgree: UISwitch!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pw: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.email.delegate = self
        self.pw.delegate = self
    }
    
    // keyboard Down
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction func actionSignUp(_ sender: Any) {
        
        
        
        
        let defaults = UserDefaults.standard
        var loginAccountDic: [String: Any]  = defaults.object(forKey: "LoginAccount") as? [String: Any] ?? [:]
        
        
        let result = email.text?.range(
            of: emailPattern,
            options: .regularExpression
        )
    
        if(email.text?.count == 0 || pw.text?.count == 0 || result == nil){
            let alert = UIAlertController(title: "Warning", message: "Check out Input!!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
      
        let isEmail = loginAccountDic[email.text ?? ""]
        
        if(isEmail != nil){
            let alert = UIAlertController(title: "Warning", message: "It already exsits!!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }else{
            loginAccountDic[email.text!] = ["pw":pw.text!, "pushagree":pushAgree.isOn]
            defaults.setValue(loginAccountDic, forKey: "LoginAccount"	)
            
            let alert = UIAlertController(title: "", message: "Account create success", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in self.navigationController?.popViewController(animated: true)}))
            self.present(alert, animated: true)
            
            
            
        }
    }
    
    
    

}
