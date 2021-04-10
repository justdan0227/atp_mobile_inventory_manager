//
//  HomeViewController.swift
//  Flight Docs Inventory Manager
//
//  Created by Dan Kardell on 4/9/21.
//

import UIKit
import SDWebImage
import SCLAlertView

class HomeViewController: UIViewController {

    var allAtpPartsArray:[ATPPartsObject] = []
    
    var filteredAtpPartsArray:[ATPPartsObject] = []
    
    var showActiveOnly = false
    var selectedIndex = -1
    
    @IBOutlet var activeSegControl: UISegmentedControl!
    @IBOutlet var partsTableView: UITableView!
    
    // ===================================================
    //
    // ===================================================
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // ===================================================
    //
    // ===================================================
    fileprivate func getFilteredArray() {
        if self.showActiveOnly {
            
            self.filteredAtpPartsArray.removeAll()
            
            for obj in self.allAtpPartsArray {
                print (obj.isActive)
                if obj.isActive  {
                    self.filteredAtpPartsArray.append(obj)
                }
            }
        }
        else  {
            self.filteredAtpPartsArray = self.allAtpPartsArray
        }
    }
    
    // ===================================================
    //
    // ===================================================
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ATPPartsObject.getAllParts() { errSecSucces,returnedArray, errorMsg  in
            
            if !errSecSucces {
                
                
                let appearance = SCLAlertView.SCLAppearance(
                    showCircularIcon: false
                )
                let alertView = SCLAlertView(appearance: appearance)
                alertView.showError("DB Error", subTitle: errorMsg)
                return
            }
            
            self.allAtpPartsArray = returnedArray
            
            self.getFilteredArray()
            
            self.partsTableView.reloadData()
        }

    }
    

    // ===================================================
    //
    // ===================================================
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "to_detail" {
            
            let vc = segue.destination as! PartsDetailViewController
            
            vc.currentPartObject = filteredAtpPartsArray[selectedIndex]
        }
    }
    
    // ===================================================
    //
    // ===================================================
    @IBAction func addPartPressed(_ sender: Any) {
        performSegue(withIdentifier: "to_create", sender: nil)
    }
    
    @IBAction func activePartToggle(_ sender: UISegmentedControl) {
        
        showActiveOnly = (sender.selectedSegmentIndex == 0) ? false : true
        getFilteredArray()
        partsTableView.reloadData()
    }
}
// ===================================================
//
// ===================================================
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedIndex = indexPath.row
        
        performSegue(withIdentifier: "to_detail", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           
           if editingStyle == .delete {
            let id = filteredAtpPartsArray[indexPath.row].id
            ATPPartsObject.deletePart(id: id) { errSecSucce in
                print ("DELETED")
                self.filteredAtpPartsArray.remove(at: indexPath.row)
               tableView.deleteRows(at: [indexPath], with: .bottom)

            }
            
           }
       }
    
}


// ===================================================
//
// ===================================================
extension HomeViewController: UITableViewDataSource {
    
    // ===================================================
    //
    // ===================================================
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredAtpPartsArray.count
    }
    
    // ===================================================
    //
    // ===================================================
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "part_cell") as? PartsTableViewCell else {return UITableViewCell()}
        
        let partObject = filteredAtpPartsArray[indexPath.row]
        
        cell.part_name.text = "Name: \(partObject.name)"
        cell.part_number.text = "# \(partObject.partNumber)"
        cell.part_number.textColor = (partObject.isActive ? .black : .red)
        cell.in_stock_amount.text = "In Stock: \(partObject.inStock)"
        
        cell.part_image.sd_setImage(with: URL(string: partObject.imageURL), placeholderImage: UIImage(named: "default_image"))
        cell.backgroundColor = indexPath.row % 2 == 0 ? #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1) : .white
        return cell
    }
    
}
