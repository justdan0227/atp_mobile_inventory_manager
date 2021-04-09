//
//  PartsDetailViewController.swift
//  Flight Docs Inventory Manager
//
//  Created by Dan Kardell on 4/9/21.
//

import UIKit
import SDWebImage

class PartsDetailViewController: UIViewController {

    
    var currentPartObject: ATPPartsObject?
    
    @IBOutlet var part_name: UILabel!
    @IBOutlet var part_number: UILabel!
    @IBOutlet var part_description: UITextView!    
    @IBOutlet var activeToggle: UISwitch!
    @IBOutlet var on_hand: UILabel!
    @IBOutlet var part_image: UIImageView!
    @IBOutlet var part_cost: UILabel!
    
    // ===================================================
    //
    // ===================================================
    fileprivate func displayTheObject() {
        // Do any additional setup after loading the view.
        
        part_name.text = "Name: \(currentPartObject!.name)"
        part_number.text = "Part # \(currentPartObject!.partNumber)"
        part_description.text = currentPartObject!.description
        on_hand.text = "In Stock: \(currentPartObject!.inStock)"
        part_cost.text = "Cost: \(currentPartObject!.cost)"
        
        activeToggle.isOn = currentPartObject!.isActive
        
        part_image.sd_setImage(with: URL(string: currentPartObject!.imageURL), placeholderImage: UIImage(named: "default_image"))
    }
    
    // ===================================================
    //
    // ===================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        displayTheObject()
    }
    
    
    // ===================================================
    //
    // ===================================================
    @IBAction func edit_pressed(_ sender: Any) {
        performSegue(withIdentifier: "to_edit", sender: nil)
    }
    
    // ===================================================
    //
    // ===================================================
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "to_edit" {
            let vc = segue.destination as! EditPartViewController
            
            vc.currentPartObject = currentPartObject
        }
    }

}
