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
        locationBuilder.setLocationName("Test office")
        
        locationBuilder.setLocationBoundaryPoints([
            EILPoint(x: 0.00, y: 0.00),
            EILPoint(x: 0.00, y: 3.05),
            EILPoint(x: 3.25, y: 3.05),
            EILPoint(x: 3.25, y: 0.00)])
        
        locationBuilder.addBeacon(withIdentifier: "554492cade78573e276c8ae7b990d739",
                                  atBoundarySegmentIndex: 0, inDistance: 1.5025, from: .leftSide)
        locationBuilder.addBeacon(withIdentifier: "616895debbed85ee3551babca24fd70d",
                                  atBoundarySegmentIndex: 1, inDistance: 1.625, from: .rightSide)
        locationBuilder.addBeacon(withIdentifier: "89d4ef27c2d20e38436d20a70ca3d53e",
                                  atBoundarySegmentIndex: 2, inDistance: 1.5025, from: .leftSide)
        locationBuilder.addBeacon(withIdentifier: "a28909a39d8324ab0b9fd458f8b1ba07",
                                  atBoundarySegmentIndex: 3, inDistance: 1.625, from: .rightSide)
        
        locationBuilder.setLocationOrientation(270)
        
        let location = locationBuilder.build()
        
        ESTConfig.setupAppID("createlocation-eo8", andAppToken: "85f01c75d54fab0f4dc1f0cce8b01e1e")
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

