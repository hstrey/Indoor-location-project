//
//  ViewController.swift
//  CloseContactPink
//
//  Created by Helmut Strey on 3/29/19.
//  Copyright © 2019 Helmut Strey. All rights reserved.
//

import UIKit

class ViewController: UIViewController, EILIndoorLocationManagerDelegate {
    
    var locationManager = EILIndoorLocationManager()
    var location: EILLocation!
    
    @IBOutlet weak var locationView: EILIndoorLocationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.locationManager.delegate = self
        
        ESTConfig.setupAppID("closecontactpink-4ry", andAppToken: "9c4ed6ee53ebe0e900afa0cf5ba211a6")
        
        self.locationManager = EILIndoorLocationManager()
        self.locationManager.delegate = self
        self.locationManager.mode = EILIndoorLocationManagerMode.normal
        
        // TODO: replace with an identifier of your own location
        // You will find the identifier on https://cloud.estimote.com/#/locations
        let fetchLocationRequest = EILRequestFetchLocation(locationIdentifier:"test-office-kr8")
        fetchLocationRequest.sendRequest { (location, error) in
            if let location = location {
                self.location = location
                
                // You can configure the location view to your liking:
                self.locationView.showTrace = true
                self.locationView.rotateOnPositionUpdate = false
                // Consult the full list of properties on:
                // http://estimote.github.io/iOS-Indoor-SDK/Classes/EILIndoorLocationView.html
                self.locationView.drawLocation(location)
                self.locationManager.startPositionUpdates(for: self.location)
            } else if let error = error {
                print("can't fetch location: \(error)")
            }
        }
        

    }

    func indoorLocationManager(_ manager: EILIndoorLocationManager, didFailToUpdatePositionWithError error: Error) {
        print("failed to update position: \(error)")
    }
    
    func indoorLocationManager(_ manager: EILIndoorLocationManager, didUpdatePosition position: EILOrientedPoint, with positionAccuracy: EILPositionAccuracy, in location: EILLocation) {
        // get string representation of current position
        let currentpos = String(format: "%5.2f,%5.2f,%3.0f", position.x, position.y, position.orientation)
        print(currentpos)
        self.locationView.updatePosition(position)
        // add it to positions
        
    }

}

