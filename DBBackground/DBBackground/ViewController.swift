//
//  ViewController.swift
//  DBBackground
//
//  Created by Helmut Strey on 3/30/19.
//  Copyright © 2019 Helmut Strey. All rights reserved.
//

import UIKit
//import SwiftyDropbox

class ViewController: UIViewController {
    
    @IBOutlet weak var colorLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let defaults = UserDefaults.standard
        locationLabel.text = defaults.object(forKey: "Location") as? String
        colorLabel.text = defaults.object(forKey: "Color") as? String

    }

//    @IBAction func connectButtonPressed() {
//                DropboxClientsManager.authorizeFromController(UIApplication.shared, controller: self, openURL: {(url: URL) -> Void in UIApplication.shared.open(url, options: [:], completionHandler: nil)})
//    }
    
}
