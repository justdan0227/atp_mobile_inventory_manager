//
//  ViewController.swift
//  Flight Docs Inventory Manager
//
//  Created by Dan Kardell on 4/9/21.
//

import UIKit

class SplashScreen: UIViewController {

    @IBOutlet var versionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        versionLabel.text = HelperFunctions.versionBuild()
    }

    @IBAction func continueBtnPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "to_home_view", sender:    nil)
        
    }
}

