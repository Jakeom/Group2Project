//
//  CreateMemory.swift
//  Group2Project
//
//  Created by Younghyun Eom on 8/2/21.
//

import UIKit

class CreateMemory: UIViewController, MapViewDelegate {

    // callback selected Map data
    func settingMapLocation(latitude: Double, longitude: Double, address: String) {
        if(address.count != 0 ){
            locationL.text = address
        }
    }
    
    
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var locationL: UILabel!
    
    // Saving Post data
    @IBAction func save(_ sender: Any) {
        
        // Validate data
        // Check content and alret
        if(content.text.count == 0){
            let alert = UIAlertController(title: "Warning", message: "Check Your Content", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in self.navigationController?.popViewController(animated: true)}))
            self.present(alert, animated: true)
            return;
        }
        
        // Get Image path  (no mandatory)
        var imagePath = ""
        if(imageView.image != nil){
            imagePath = saveImage(image: imageView.image!)
        }
        
        
        // Make Current date
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd.YYYY HH:mm:ss"
        let now = dateFormatter.string(from: date)
        
        
        // Saving Data in userdefaults
        let defaults = UserDefaults.standard
        let lastLoginId = defaults.object(forKey: "lastLogin") as! String
        let listKey = "postData-"+lastLoginId
        var postData  = defaults.array(forKey: listKey)
        
        // Get Location Value
        var loct = ""
        if(locationL.text != "Share your location."	){
            loct = locationL.text ?? ""
        }
        
        // Make base Post Dictionary.
        let data = ["imagePath":imagePath, "content":content.text!, "location": loct, "date": now]
        // Setting Data
        if(postData != nil){  // Not a first time
            postData?.append(data)
            defaults.setValue(postData, forKey: listKey)
        }else{ // First time setting
            defaults.setValue([data], forKey: listKey)
        }
       
        // Alert Sucess messgae
        let alert = UIAlertController(title: "Success!", message: "Saved Post", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in self.navigationController?.popViewController(animated: true)}))
        self.present(alert, animated: true)
        
        // Reset Data
        locationL.text = "Share your location."
        imageView.image = nil
        content.text = ""
        
        // down keyboard
        self.view.endEditing(true)
    }
    
    // keyboard Down
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Init ImagePicker Object
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)

    }
    
    // Save image inside App and return Filename
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
    
    // Call ImagePicker Obejct
    var imagePicker: ImagePicker!
    
    // Show Gallery
    @IBAction func showImagePicker(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    // Move Select location page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapsegue" {
            let mapView = segue.destination as! MapViewCotroller
            mapView.delegate = self
        }
    }
    
}

// Callback Image pick in the gallery
extension CreateMemory: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        self.imageView.image = image
    }
}
