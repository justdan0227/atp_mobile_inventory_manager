//
//  PartsTableViewCell.swift
//  Flight Docs Inventory Manager
//
//  Created by Dan Kardell on 4/9/21.
//

import UIKit

class PartsTableViewCell: UITableViewCell {

    @IBOutlet var part_number: UILabel!
    @IBOutlet var part_name: UILabel!
    @IBOutlet var in_stock_amount: UILabel!
    @IBOutlet var part_image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
