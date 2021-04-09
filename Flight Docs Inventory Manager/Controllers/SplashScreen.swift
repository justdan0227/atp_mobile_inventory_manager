//
//  ViewController.swift
//  Flight Docs Inventory Manager
//
//  Created by Dan Kardell on 4/9/21.
//

import UIKit

class SplashScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func continueBtnPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "to_home_view", sender:    nil)
        
    }
}

