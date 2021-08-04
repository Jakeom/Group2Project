//
//  HomePage.swift
//  Group2Project
//
//  Created by Harpreet on 8/2/21.
//

import UIKit

class HomePage: UIViewController, UITableViewDelegate, UITableViewDataSource, TableViewCellDelegate {
    
    // Data Structure
    //        {"account": {"youraccount1":{"pw":"agree"},"youraccount2":{"pw":"agree"}}
    //         "postData-youraccount1" : [{},{},{}]
    //         "postData-youraccount2" : [{},{},{}]
    //        }

    func deleteTableItem(_ cell: TableViewCell) {
        print("tableview Delegate sample")
    }
    

    var stuArry = Array<Any>()
    // defind table view
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // related talbeview delegate
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // ever show home-page updated tabaleView row.
        
        let defaults = UserDefaults.standard
        let lastLoginId = defaults.object(forKey: "lastLogin") as! String
        let listKey = "postData-"+lastLoginId

        // get post data
        let stuArry1  = defaults.array(forKey: listKey) ?? []
        
        // make order by Date
        self.stuArry = []
        for tmp in stuArry1.reversed() {
            stuArry.append(tmp)
        }
        
        // reload talbeview
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
        // call talbeviewcell
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! TableViewCell
        
        
        // get row data
        // Data Structure
        // ["imagePath":imagePath, "content":content.text!, "location": loct, "date": now]
        let data = stuArry[indexPath.row] as? Dictionary<String, String>

        cell.delegate = self    // set delegate inside cell
        let imagePath = data?["imagePath"] ?? "" //get main image path
        let date = data?["date"] ?? ""  // get date
        let location = data?["location"] ?? "" // get location
        let content = data?["content"] ?? "" // get content
        
        // setting Image inside Cell
        if(imagePath.count != 0){
            cell.myImage.image = getSavedImage(named: imagePath)
        }else{
            cell.myImage.image = nil
        }
        // setting Date info to lable in Cell
        cell.dateLabel.text = "Date : " + date
        
        // setting Location info to lable in Cell
        if(location.count != 0){
            cell.locationLabel.text = "Location : " + location
        }else{
            cell.locationLabel.text = ""
        }
        
        // setting Content info to lable in Cell
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
    
    // Image call inside app as a string path
    func getSavedImage(named: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        return nil
    }

}
