//
//  AppDelegate.swift
//  DBBackground
//
//  Created by Helmut Strey on 3/30/19.
//  Copyright © 2019 Helmut Strey. All rights reserved.
//

import UIKit
import SwiftyDropbox
import EstimoteProximitySDK

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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,
                    EILBackgroundIndoorLocationManagerDelegate {

    var window: UIWindow?
    var positions = ""
    var startdate = getTodayString()
    var proximityObserver: ProximityObserver!
    var backgroundTaskID = UIBackgroundTaskIdentifier.invalid
    
    let backgroundIndoorManager = EILBackgroundIndoorLocationManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        ESTConfig.setupAppID("closecontact-nqa", andAppToken: "df38b7894b8841c1707ba7471aa3e34a")
        
        self.backgroundIndoorManager.delegate = self
        self.backgroundIndoorManager.requestAlwaysAuthorization()
        
        let fetchLocation = EILRequestFetchLocation(locationIdentifier: "helmut-office")
        fetchLocation.sendRequest { (location, error) in
            if let location = location {
                self.backgroundIndoorManager.startPositionUpdates(for: location)
            } else {
                print("can't fetch location: \(String(describing: error))")
            }
        }
        
        DropboxClientsManager.setupWithAppKey("ntx5fdghd485naq")
        
        let cloudCredentials = CloudCredentials(appID: "closecontact-nqa",
                                                appToken: "df38b7894b8841c1707ba7471aa3e34a")
        
        self.proximityObserver = ProximityObserver(
            credentials: cloudCredentials,
            onError: { error in
                print("proximity observer error: \(error)")
        })
        
        let zone_05 = ProximityZone(tag: "pink", range: ProximityRange(desiredMeanTriggerDistance: 0.5)!)
        
        zone_05.onEnter = { _ in
            print("<0.5 to pink")
            self.positions = self.positions + getTimeString() + " <0.5 to pink\n"
        }
        zone_05.onExit = { _ in
            print("<0.5 exit pink")
            self.positions = self.positions + getTimeString() + " <0.5 exit pink\n"
        }
        
        let zone_10 = ProximityZone(tag: "pink", range: ProximityRange(desiredMeanTriggerDistance: 1.0)!)
        zone_10.onEnter = { _ in
            print("<1.0 to pink")
            self.positions = self.positions + getTimeString() + " <1.0 to pink\n"
        }
        zone_10.onExit = { _ in
            print("<1.0 exit pink")
            self.positions = self.positions + getTimeString() + " <1.0 exit pink\n"
        }
        
        let zone_20 = ProximityZone(tag: "pink", range: ProximityRange(desiredMeanTriggerDistance: 2.0)!)
        zone_20.onEnter = { _ in
            print("<2.0 to pink")
            self.positions = self.positions + getTimeString() + " <2.0 to pink\n"
        }
        zone_20.onExit = { _ in
            print("<2.0 exit pink")
            self.positions = self.positions + getTimeString() + " <2.0 exit pink\n"
        }
        
        let zone_30 = ProximityZone(tag: "pink", range: ProximityRange(desiredMeanTriggerDistance: 3.0)!)
        zone_30.onEnter = { _ in
            print("<3.0 to pink")
            self.positions = self.positions + getTimeString() + " <3.0 to pink\n"
        }
        zone_30.onExit = { _ in
            print("<3.0 exit pink")
            self.positions = self.positions + getTimeString() + " <3.0 exit pink\n"
        }
        
        let zone_40 = ProximityZone(tag: "pink", range: ProximityRange(desiredMeanTriggerDistance: 4.0)!)
        zone_40.onEnter = { _ in
            print("<4.0 to pink")
            self.positions = self.positions + getTimeString() + " <4.0 to pink\n"
        }
        zone_40.onExit = { _ in
            print("<4.0 exit pink")
            self.positions = self.positions + getTimeString() + " <4.0 exit pink\n"
        }
        
        self.proximityObserver.startObserving([zone_05,zone_10,zone_20,zone_30,zone_40])

        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if let authResult = DropboxClientsManager.handleRedirectURL(url) {
            switch authResult {
            case .success:
                print("Success! User is logged into Dropbox.")
            case .cancel:
                print("Authorization flow was manually canceled by user!")
            case .error(_, let description):
                print("Error: \(description)")
            }
        }
        return true
    }
    
    func backgroundIndoorLocationManager(
        _ locationManager: EILBackgroundIndoorLocationManager,
        didFailToUpdatePositionWithError error: Error) {
        print("failed to update position: \(error)")
    }
    
    func backgroundIndoorLocationManager(
        _ manager: EILBackgroundIndoorLocationManager,
        didUpdatePosition position: EILOrientedPoint,
        with positionAccuracy: EILPositionAccuracy,
        in location: EILLocation) {
        
        // get string representation of current position
        let currentpos = String(format: "%5.2f,%5.2f", position.x, position.y)
        print(currentpos)
        self.positions = self.positions + getTimeString() + " " + currentpos + "\n"
        // if position data exceeds 10,000 characters save it to dropbox
        if self.positions.count > 10000 {
            sendPositionsToDB(data: self.positions)
            self.positions = ""
            self.startdate = getTodayString()
        }

    }
    
    func sendPositionsToDB( data : String ) {
        // Perform the task on a background queue.
        DispatchQueue.global().async {
            // Request the task assertion and save the ID.
            self.backgroundTaskID = UIApplication.shared.beginBackgroundTask (withName: "Finish Saving Data") {
                // End the task if time expires.
                UIApplication.shared.endBackgroundTask(self.backgroundTaskID)
                self.backgroundTaskID = UIBackgroundTaskIdentifier.invalid
            }
            
            // Send the data synchronously.
            if let client = DropboxClientsManager.authorizedClient {
                let fileData = data.data(using: String.Encoding.utf8, allowLossyConversion: false)!
                let _ = client.files.upload(path: "/test"+self.startdate+".txt", mode: .overwrite, autorename: false, input: fileData)
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
            
            // End the task assertion.
            UIApplication.shared.endBackgroundTask(self.backgroundTaskID)
            self.backgroundTaskID = UIBackgroundTaskIdentifier.invalid
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        print("applicationDidEnterBackground")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        print("applicationWillTerminate")
    }


}

