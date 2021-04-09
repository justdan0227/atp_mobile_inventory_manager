//
//  HomeViewController.swift
//  Flight Docs Inventory Manager
//
//  Created by Dan Kardell on 4/9/21.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {

    var atpPartsArray:[ATPPartsObject] = []
    
    var selectedIndex = -1
    
    @IBOutlet var partsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ATPPartsObject.getAllParts() { errSecSucces,returnedArray  in
            print ("Made it")
            self.atpPartsArray = returnedArray
            self.partsTableView.reloadData()
        }

    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "to_detail" {
            
            let vc = segue.destination as! PartsDetailViewController
            
            vc.currentPartObject = atpPartsArray[selectedIndex]
        }
    }
    
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedIndex = indexPath.row
        
        performSegue(withIdentifier: "to_detail", sender: nil)
    }
    
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return atpPartsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "part_cell") as? PartsTableViewCell else {return UITableViewCell()}
        
        cell.part_name.text = "Name: \(atpPartsArray[indexPath.row].name)"
        cell.part_number.text = "# \(atpPartsArray[indexPath.row].partNumber)"
        cell.in_stock_amount.text = "In Stock: \(atpPartsArray[indexPath.row].inStock)"
        
        cell.part_image.sd_setImage(with: URL(string: atpPartsArray[indexPath.row].imageURL), placeholderImage: UIImage(named: "wait"))
        
        return cell
    }
    
    
}

