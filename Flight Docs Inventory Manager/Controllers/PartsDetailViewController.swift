//
//  PartsDetailViewController.swift
//  Flight Docs Inventory Manager
//
//  Created by Dan Kardell on 4/9/21.
//

import UIKit
import SDWebImage
import SCLAlertView
import IQKeyboardManagerSwift

class PartsDetailViewController: UIViewController {

    var currentPartObject: ATPPartsObject?
    
    @IBOutlet var part_name: UILabel!
    @IBOutlet var part_number: UILabel!
    @IBOutlet var part_description: UITextView!    
    @IBOutlet var activeToggle: UISwitch!
    @IBOutlet var on_hand: UILabel!
    @IBOutlet var part_image: UIImageView!
    @IBOutlet var part_cost: UILabel!
    @IBOutlet var consumeBtn: UIButton!
    
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
        consumeBtn.isHidden = (currentPartObject!.inStock == 0)
    }
    
    // ===================================================
    //
    // ===================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.shared.shouldPlayInputClicks = false
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
    

    // ===================================================
    //
    // ===================================================
    @IBAction func consumeBtnPressed(_ sender: Any) {
        let receivedAmount = promptForAmount(isConsume: true, title: "Received Amount",
                        subTitle: "Plese enter the received amount")


    }
    // ===================================================
    //
    // ===================================================
    @IBAction func receiveBtnPressed(_ sender: Any) {
        let receivedAmount = promptForAmount(isConsume: false, title: "Received Amount",
                        subTitle: "Plese enter the received amount")
    }
    
    // ===================================================
    //
    // ===================================================
    func promptForAmount(isConsume: Bool, title: String, subTitle: String) {
    
     let appearance = SCLAlertView.SCLAppearance(
         showCloseButton: false, showCircularIcon: false
     )
     
     let alertView = SCLAlertView(appearance: appearance)
     
     let txt = alertView.addTextField("0")
        
    txt.becomeFirstResponder()
     txt.keyboardType = .numberPad
     
        alertView.addButton(isConsume ? "CONSUME" : " RECEIVE",
                            backgroundColor: UIColor(red: 0.216, green: 0.780, blue: 0.349, alpha: 1.00),
                            textColor: .white) {
        let intString = txt.text!
        if intString.count != 0 {
            let amount = Int(intString) ?? 0
            if isConsume {
                if (self.currentPartObject!.inStock - amount) < 0 {
                    SCLAlertView().showError("CONSUME ERROR",
                                             subTitle: "You can not consume more than \(self.currentPartObject!.inStock) items")
                    return
                }
                self.currentPartObject?.inStock -= amount
            }
            else {
                self.currentPartObject?.inStock += amount
            }
            self.on_hand.text = "In Stock: \(self.currentPartObject!.inStock)"
            ATPPartsObject.updatePart(updatedATPPartObject: self.currentPartObject!) { errSecSuccess in
                
            }
        }
    
     }
        
     alertView.addButton("CANCEL", backgroundColor: .red, textColor: .white) {
     }

     
     alertView.showTitle(
        title, // Title of view
         subTitle: subTitle,
         timeout: nil, // String of view
         completeText: "CANCEL", // Optional button value, default: ""
         style: .edit // Styles - see below.
     )
     // case success, error, no
     
    }
}
