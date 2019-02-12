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
    let locationManager = EILIndoorLocationManager()
    var location: EILLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 3. Set the location manager's delegate
        self.locationManager.delegate = self
        
        ESTConfig.setupAppID("helloindoor-58j", andAppToken: "9ffdcc7c153efd1531abfd00c463c1c7")
        
        let fetchLocationRequest = EILRequestFetchLocation(locationIdentifier: "test-office-kr8")
        fetchLocationRequest.sendRequest { (location, error) in
            if location != nil {
                self.location = location!
                self.locationManager.startPositionUpdates(for: self.location)
            } else {
                print("can't fetch location: \(String(describing: error))")
            }
        }
    }

    func indoorLocationManager(_ manager: EILIndoorLocationManager,
                               didFailToUpdatePositionWithError error: Error) {
        print("failed to update position: \(String(describing: error))")
    }
    
    func indoorLocationManager(_ manager: EILIndoorLocationManager,
                               didUpdatePosition position: EILOrientedPoint,
                               with positionAccuracy: EILPositionAccuracy,
                               in location: EILLocation) {
        var accuracy: String!
        switch positionAccuracy {
        case .veryHigh: accuracy = "+/- 1.00m"
        case .high:     accuracy = "+/- 1.62m"
        case .medium:   accuracy = "+/- 2.62m"
        case .low:      accuracy = "+/- 4.24m"
        case .veryLow:  accuracy = "+/- ? :-("
        case .unknown:  accuracy = "unknown"
        }
        print(String(format: "x: %5.2f, y: %5.2f, orientation: %3.0f, accuracy: %@",
                     position.x, position.y, position.orientation, accuracy))
    }

}

