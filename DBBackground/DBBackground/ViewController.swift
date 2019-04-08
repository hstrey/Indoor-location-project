//
//  ViewController.swift
//  DBBackground
//
//  Created by Helmut Strey on 3/30/19.
//  Copyright © 2019 Helmut Strey. All rights reserved.
//

import UIKit
import SwiftyDropbox

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func connectButtonPressed() {
                DropboxClientsManager.authorizeFromController(UIApplication.shared, controller: self, openURL: {(url: URL) -> Void in UIApplication.shared.open(url, options: [:], completionHandler: nil)})
    }
    
}

