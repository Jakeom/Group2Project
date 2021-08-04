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
            
            let dPw = isEmail["pw"] ?? ""
            let _pw = pw.text
            if(_pw != dPw as? String ){
                let alert = UIAlertController(title: "Login Fail!", message: "Check the Password!!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
                self.present(alert, animated: true)
                return
            }
            
        }
        
        defaults.setValue(email.text!, forKey: "lastLogin")
        pw.text = ""
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
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func saveImage(image: UIImage) -> String {
        guard let data = image.jpegData(compressionQuality: 0.8) ?? image.pngData() else {
            return ""
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return ""
        }
        do {
            let uuid = UUID().uuidString
            try data.write(to: directory.appendingPathComponent(uuid)!)
            return uuid
        } catch {
            print(error.localizedDescription)
            return ""
        }
        
    }
    
    func getSavedImage(named: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        return nil
    }
    
}
