//
//  AppDelegate.swift
//  TrackingRemotely
//
//  Created by Helmut Strey on 3/22/19.
//  Copyright © 2019 Helmut Strey. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,
        EILBackgroundIndoorLocationManagerDelegate {

    let backgroundIndoorManager = EILBackgroundIndoorLocationManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ESTConfig.setupAppID("trackremotely-o6r", andAppToken: "c480f343ef19ed5aa78a08aa775d998c")
        
        self.backgroundIndoorManager.delegate = self
        self.backgroundIndoorManager.requestAlwaysAuthorization()
        
        let fetchLocation = EILRequestFetchLocation(locationIdentifier: "test-office-kr8")
        fetchLocation.sendRequest { (location, error) in
            if let location = location {
                self.backgroundIndoorManager.startPositionUpdates(for: location)
                print("found location")
            } else {
                print("can't fetch location: \(String(describing: error))")
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
        print(String(format: "x: %5.2f, y: %5.2f, orientation: %3.0f", position.x, position.y, position.orientation))
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

