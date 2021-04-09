//
//  PartsDetailViewController.swift
//  Flight Docs Inventory Manager
//
//  Created by Dan Kardell on 4/9/21.
//

import UIKit

class PartsDetailViewController: UIViewController {

    
    var currentPartObject: ATPPartsObject?
    
    @IBOutlet var part_name: UILabel!
    @IBOutlet var part_number: UILabel!
    @IBOutlet var part_description: UITextView!    
    @IBOutlet var activeToggle: UISwitch!
    @IBOutlet var on_hand: UILabel!
    @IBOutlet var part_image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        part_name.text = "Name: \(currentPartObject!.name)"
        part_number.text = "Part # \(currentPartObject!.partNumber)"
        part_description.text = currentPartObject!.description
        on_hand.text = "In Stock: \(currentPartObject!.inStock)"
        part_image.sd_setImage(with: URL(string: currentPartObject!.imageURL), placeholderImage: UIImage(named: "wait"))
        
        
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
