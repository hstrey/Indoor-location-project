//
//  ViewController.swift
//  CloseContactPink
//
//  Created by Helmut Strey on 3/29/19.
//  Copyright © 2019 Helmut Strey. All rights reserved.
//

import UIKit
import EstimoteProximitySDK
import SwiftyDropbox

func getTodayString() -> String{
    
    let date = Date()
    let calender = Calendar.current
    let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
    
    let year = components.year
    let month = components.month
    let day = components.day
    let hour = components.hour
    let minute = components.minute
    let second = components.second
    
    let today_string = String(year!) + "-" + String(month!) + "-" + String(day!) + " " + String(hour!)  + ":" + String(minute!) + ":" +  String(second!)
    
    return today_string
}

func getTimeString() -> String{
    
    let date = Date()
    let calender = Calendar.current
    let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
    
    let hour = components.hour
    let minute = components.minute
    let second = components.second
    
    let time_string = String(hour!)  + ":" + String(minute!) + ":" +  String(second!)
    return time_string
}

class ViewController: UIViewController, EILIndoorLocationManagerDelegate {
    
    var locationManager = EILIndoorLocationManager()
    var location: EILLocation!
    var startdate = getTodayString()
    var positions = ""
    var proximityObserver: ProximityObserver!
    
    @IBOutlet weak var locationView: EILIndoorLocationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DropboxClientsManager.authorizeFromController(UIApplication.shared, controller: self, openURL: {(url: URL) -> Void in UIApplication.shared.open(url, options: [:], completionHandler: nil)})

        // Do any additional setup after loading the view.
        self.locationManager.delegate = self
        
        ESTConfig.setupAppID("closecontactpink-4ry", andAppToken: "9c4ed6ee53ebe0e900afa0cf5ba211a6")
        
        self.locationManager = EILIndoorLocationManager()
        self.locationManager.delegate = self
        self.locationManager.mode = EILIndoorLocationManagerMode.normal
        
        // TODO: replace with an identifier of your own location
        // You will find the identifier on https://cloud.estimote.com/#/locations
        let fetchLocationRequest = EILRequestFetchLocation(locationIdentifier:"clv-apartment-3")
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
        
        let cloudCredentials = CloudCredentials(appID: "closecontactpink-4ry",
                                                appToken: "9c4ed6ee53ebe0e900afa0cf5ba211a6")
        
        self.proximityObserver = ProximityObserver(
            credentials: cloudCredentials,
            onError: { error in
                print("proximity observer error: \(error)")
        })
        
        let zone_05 = ProximityZone(tag: "silver", range: ProximityRange(desiredMeanTriggerDistance: 0.5)!)
        
        zone_05.onEnter = { _ in
            print("<0.5 to silver")
            self.positions = self.positions + getTimeString() + " <0.5 to silver\n"
        }
        zone_05.onExit = { _ in
            print("<0.5 exit silver")
            self.positions = self.positions + getTimeString() + " <0.5 exit silver\n"
        }
        
        let zone_10 = ProximityZone(tag: "silver", range: ProximityRange(desiredMeanTriggerDistance: 1.0)!)
        zone_10.onEnter = { _ in
            print("<1.0 to silver")
            self.positions = self.positions + getTimeString() + " <1.0 to silver\n"
        }
        zone_10.onExit = { _ in
            print("<1.0 exit silver")
            self.positions = self.positions + getTimeString() + " <1.0 exit silver\n"
        }
        
        let zone_20 = ProximityZone(tag: "silver", range: ProximityRange(desiredMeanTriggerDistance: 2.0)!)
        zone_20.onEnter = { _ in
            print("<2.0 to silver")
            self.positions = self.positions + getTimeString() + " <2.0 to silver\n"
        }
        zone_20.onExit = { _ in
            print("<2.0 exit silver")
            self.positions = self.positions + getTimeString() + " <2.0 exit silver\n"
        }
        
        let zone_30 = ProximityZone(tag: "silver", range: ProximityRange(desiredMeanTriggerDistance: 3.0)!)
        zone_30.onEnter = { _ in
            print("<3.0 to silver")
            self.positions = self.positions + getTimeString() + " <3.0 to silver\n"
        }
        zone_30.onExit = { _ in
            print("<3.0 exit silver")
            self.positions = self.positions + getTimeString() + " <3.0 exit silver\n"
        }
        
        let zone_40 = ProximityZone(tag: "silver", range: ProximityRange(desiredMeanTriggerDistance: 4.0)!)
        zone_40.onEnter = { _ in
            print("<4.0 to silver")
            self.positions = self.positions + getTimeString() + " <4.0 to silver\n"
        }
        zone_40.onExit = { _ in
            print("<4.0 exit silver")
            self.positions = self.positions + getTimeString() + " <4.0 exit silver\n"
        }
        
        self.proximityObserver.startObserving([zone_05,zone_10,zone_20,zone_30,zone_40])
        
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
        self.positions = self.positions + getTimeString() + " " + currentpos + "\n"
        
        if self.positions.count > 10000 {
            if let client = DropboxClientsManager.authorizedClient {
                let fileData = self.positions.data(using: String.Encoding.utf8, allowLossyConversion: false)!
                let _ = client.files.upload(path: "/pink"+self.startdate+".txt", mode: .overwrite, autorename: false, input: fileData)
                    .response { response, error in
                        if let response = response {
                            print(response)
                        } else if let error = error {
                            print(error)
                        }
                    }
                    .progress { progressData in
                        print(progressData)
                }
                
            }
            else {
                print("not authorized")
            }
            self.positions = ""
            self.startdate = getTodayString()
        }
    }

}

