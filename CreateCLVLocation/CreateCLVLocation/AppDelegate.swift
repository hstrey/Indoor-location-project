//
//  AppDelegate.swift
//  CreateCLVLocation
//
//  Created by Helmut Strey on 3/29/19.
//  Copyright © 2019 Helmut Strey. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let locationBuilder = EILLocationBuilder()
        locationBuilder.setLocationName("CLV apartment test")
        
        locationBuilder.setLocationBoundaryPoints([
            EILPoint(x: 0.00, y: 0.00),
            EILPoint(x: 0.00, y: 9.85),
            EILPoint(x: 4.56, y: 9.85),
            EILPoint(x: 4.56, y: 0.00)])
        
        locationBuilder.addBeacon(withIdentifier: "ed19942889b711d44bb1e3eda5184833",
                                  atBoundarySegmentIndex: 0, inDistance: 3.5, from: .leftSide)
        locationBuilder.addBeacon(withIdentifier: "211884e42e45a6e37397d33076d1483e",
                                  atBoundarySegmentIndex: 1, inDistance: 1.1, from: .rightSide)
        locationBuilder.addBeacon(withIdentifier: "d9db571ad6dce14013c21446460d4819",
                                  atBoundarySegmentIndex: 2, inDistance: 5.7, from: .leftSide)
        locationBuilder.addBeacon(withIdentifier: "9b66bca40167315563b7b62fe964e735",
                                  atBoundarySegmentIndex: 3, inDistance: 2.4, from: .rightSide)
        locationBuilder.setLocationOrientation(50)
        
        let location = locationBuilder.build()!
        
        ESTConfig.setupAppID("createclvlocation-9ls", andAppToken: "4db670a56637b42b5659b943ebfdcf10")
        let addLocationRequest = EILRequestAddLocation(location: location)
        addLocationRequest.sendRequest { (location, error) in
            if error != nil {
                NSLog("Error when saving location: \(String(describing: error))")
            } else {
                NSLog("Location saved successfully: \(String(describing: location?.identifier))")
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

