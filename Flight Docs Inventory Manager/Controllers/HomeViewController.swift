//
//  HomeViewController.swift
//  Flight Docs Inventory Manager
//
//  Created by Dan Kardell on 4/9/21.
//

import UIKit
import SDWebImage

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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ATPPartsObject.getAllParts() { errSecSucces,returnedArray  in
            
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
    
}


// ===================================================
//
// ===================================================
extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredAtpPartsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "part_cell") as? PartsTableViewCell else {return UITableViewCell()}
        
        cell.part_name.text = "Name: \(filteredAtpPartsArray[indexPath.row].name)"
        cell.part_number.text = "# \(filteredAtpPartsArray[indexPath.row].partNumber)"
        cell.in_stock_amount.text = "In Stock: \(filteredAtpPartsArray[indexPath.row].inStock)"
        
        cell.part_image.sd_setImage(with: URL(string: filteredAtpPartsArray[indexPath.row].imageURL), placeholderImage: UIImage(named: "default_image"))
        
        return cell
    }
    
}
