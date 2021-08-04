//
//  TableViewCell.swift
//  Group2Project
//
//  Created by user197710 on 8/3/21.
//

import UIKit

protocol TableViewCellDelegate{
    func deleteTableItem(_ cell: TableViewCell)
}

class TableViewCell: UITableViewCell {

    var delegate: TableViewCellDelegate?
//    @IBAction func delAction(_ sender: Any) {
//        self.delegate?.deleteTableItem(self)
//    }
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var contentabel: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
