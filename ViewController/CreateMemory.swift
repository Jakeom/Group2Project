//
//  CreateMemory.swift
//  Group2Project
//
//  Created by user196663 on 8/2/21.
//

import UIKit

class CreateMemory: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        
        // get Current Date
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY/MM/dd HH:mm:ss"
        dateFormatter.string(from: date)
        // Do any additional setup after loading the view.
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
