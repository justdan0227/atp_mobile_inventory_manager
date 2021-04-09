//
//  HomeViewController.swift
//  Flight Docs Inventory Manager
//
//  Created by Dan Kardell on 4/9/21.
//

import UIKit

class HomeViewController: UIViewController {

    var atpPartsArray:[ATPPartsObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func listParts(_ sender: Any) {
        
        var obj = ATPPartsObject()
        
        obj.getPart(partNumber: "") { errSecSucces,returnedArray  in
            print ("Made it")
            self.atpPartsArray = returnedArray
        }
    }
}
