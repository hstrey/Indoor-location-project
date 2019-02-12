//
//  ViewController.swift
//  HelloIndoor
//
//  Created by Helmut Strey on 2/12/19.
//  Copyright © 2019 Helmut Strey. All rights reserved.
//

import UIKit

// 1. Add the EILIndoorLocationManagerDelegate protocol
class ViewController: UIViewController, EILIndoorLocationManagerDelegate  {
    
    // 2. Add the location manager
    var locationManager = EILIndoorLocationManager()
    var location: EILLocation!
    
    @IBOutlet weak var locationView: EILIndoorLocationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 3. Set the location manager's delegate
        self.locationManager.delegate = self
        
        ESTConfig.setupAppID("helloindoor-58j", andAppToken: "9ffdcc7c153efd1531abfd00c463c1c7")
        
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
        print(String(format: "x: %5.2f, y: %5.2f, orientation: %3.0f", position.x, position.y, position.orientation))
        
        self.locationView.updatePosition(position)
    }


}

