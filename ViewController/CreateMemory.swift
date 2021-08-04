//
//  CreateMemory.swift
//  Group2Project
//
//  Created by user196663 on 8/2/21.
//

import UIKit

class CreateMemory: UIViewController {
    
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var locationL: UILabel!
    @IBAction func save(_ sender: Any) {
        
        if(content.text.count == 0){
            let alert = UIAlertController(title: "Warning", message: "Check Your Content", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in self.navigationController?.popViewController(animated: true)}))
            self.present(alert, animated: true)
            return;
        }
        var imagePath = ""
        if(imageView.image != nil){
            imagePath = saveImage(image: imageView.image!)
        }
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd.YYYY HH:mm:ss"
        let now = dateFormatter.string(from: date)
        
        
        let defaults = UserDefaults.standard
        let lastLoginId = defaults.object(forKey: "lastLogin") as! String
        let listKey = "postData-"+lastLoginId
        var postData  = defaults.array(forKey: listKey)
        
        var loct = ""
        if(locationL.text != "Share your location."	){
            loct = locationL.text ?? ""
        }
        
        let data = ["imagePath":imagePath, "content":content.text!, "location": loct, "data": now]
        if(postData != nil){
            
            postData?.append(data)
            defaults.setValue(postData, forKey: listKey)
        }else{
            defaults.setValue([data], forKey: listKey)
        }
       
        let alert = UIAlertController(title: "Success!", message: "Saved Post", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in self.navigationController?.popViewController(animated: true)}))
        self.present(alert, animated: true)
        
        // reset Data
        locationL.text = "Share your location."
        imageView.image = nil
        content.text = ""
        
        // down keyboard
        self.view.endEditing(true)
    }
    
    @IBAction func moveMapSearch(_ sender: Any) {
        
    }
    
    // keyboard Down
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        
        // get Current Date
        
        // Do any additional setup after loading the view.
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
    
    
    @IBOutlet var imageView: UIImageView!
    
    var imagePicker: ImagePicker!
    
    @IBAction func showImagePicker(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
}

extension CreateMemory: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        self.imageView.image = image
    }
}
