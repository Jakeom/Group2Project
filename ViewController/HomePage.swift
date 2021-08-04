//
//  HomePage.swift
//  Group2Project
//
//  Created by user196663 on 8/2/21.
//

import UIKit

class HomePage: UIViewController, UITableViewDelegate, UITableViewDataSource, TableViewCellDelegate {
    
    
    func deleteTableItem(_ cell: TableViewCell) {
        print("tableview Delegate sample")
    }
    

    var stuArry = Array<Any>()
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        
        self.myTableView.estimatedRowHeight = 400
        self.myTableView.rowHeight = UITableView.automaticDimension
        
        
      
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        let lastLoginId = defaults.object(forKey: "lastLogin") as! String
        let listKey = "postData-"+lastLoginId
        let stuArry1  = defaults.array(forKey: listKey) ?? []
        
        self.stuArry = []
        for tmp in stuArry1.reversed() {
            stuArry.append(tmp)
        }
        self.myTableView.reloadData()
    }
    
    // tableview Section of count
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
//    // tableview set height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    // tableview cell count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stuArry.count
    }
    
    // tableviewcell controll
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Useing Mycell of indentify what I have defined on storyboard
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! TableViewCell
        
        let datas = stuArry[indexPath.row] as? Dictionary<String, String>

        cell.delegate = self
        let imagePath = datas?["imagePath"] ?? ""
        let date = datas?["data"] ?? ""
        let location = datas?["location"] ?? ""
        let content = datas?["content"] ?? ""
        if(imagePath.count != 0){
            cell.myImage.image = getSavedImage(named: imagePath)
        }else{
            cell.myImage.image = nil
        }
        // let data = ["imagePath":imagePath, "content":content.text!, "location": loct, "data": now]
        cell.dateLabel.text = "Date : " + date
        if(location.count != 0){
            cell.locationLabel.text = "Location : " + location
        }else{
            cell.locationLabel.text = ""
        }
        
        cell.contentabel.text = content
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        
        //Create a new swipe action
        let action = UIContextualAction(style: .destructive, title: "delete") { (action, view, completionHandler) in
            self.stuArry.remove(at: indexPath.row)
            self.myTableView.reloadData()
        }
        
        //Return swipe Action
        return UISwipeActionsConfiguration(actions: [action])

    }
    
    func getSavedImage(named: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        return nil
    }

}
