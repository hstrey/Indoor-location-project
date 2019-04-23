//
//  AppDelegate.swift
//  CreateLocation
//
//  Created by Helmut Strey on 2/12/19.
//  Copyright © 2019 Helmut Strey. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let locationBuilder = EILLocationBuilder()
        locationBuilder.setLocationName("Helmut office")
        
        locationBuilder.setLocationBoundaryPoints([
            EILPoint(x: 0.00, y: 0.00),
            EILPoint(x: 0.00, y: 3.05),
            EILPoint(x: 3.25, y: 3.05),
            EILPoint(x: 3.25, y: 0.00)])
        
        locationBuilder.addBeacon(withIdentifier: "c563757306988484b5d0b1d91f32b635",
                                  atBoundarySegmentIndex: 0, inDistance: 1.5025, from: .leftSide)
        locationBuilder.addBeacon(withIdentifier: "bb47bd3e4f3216eda46b5b882472571a",
                                  atBoundarySegmentIndex: 1, inDistance: 1.625, from: .rightSide)
        locationBuilder.addBeacon(withIdentifier: "ab2f4dc90d0be48bbe5ebfa1ebc0f713",
                                  atBoundarySegmentIndex: 2, inDistance: 1.5025, from: .leftSide)
        locationBuilder.addBeacon(withIdentifier: "fb1173b046a2f59dbde3b6d47a6ac414",
                                  atBoundarySegmentIndex: 3, inDistance: 1.625, from: .rightSide)
        
        locationBuilder.setLocationOrientation(270)
        
        let location = locationBuilder.build()
        
        ESTConfig.setupAppID("createclvlocation-9ls", andAppToken: "4db670a56637b42b5659b943ebfdcf10")
        let addLocationRequest = EILRequestAddLocation(location: location!)
        addLocationRequest.sendRequest { (location, error) in
            if error != nil {
                NSLog("Error when saving location: \(String(describing: error))")
            } else {
                NSLog("Location saved successfully: \(String(describing: location!.identifier))")
            }
        }
        
        return true
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

