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
        locationBuilder.setLocationName("Helmut Office")
        
//        locationBuilder.setLocationBoundaryPoints([
//            EILPoint(x: 0.00, y: 0.00),
//            EILPoint(x: 0.00, y: 4.27),
//            EILPoint(x: 1.93, y: 4.27),
//            EILPoint(x: 1.93, y: 4.98),
//            EILPoint(x: 0.33, y: 4.98),
//            EILPoint(x: 0.33, y: 6.27),
//            EILPoint(x: 2.54, y: 6.27),
//            EILPoint(x: 2.54, y: 6.73),
//            EILPoint(x: 3.94, y: 6.73),
//            EILPoint(x: 3.94, y: 3.96),
//            EILPoint(x: 5.74, y: 3.96),
//            EILPoint(x: 5.74, y: 6.63),
//            EILPoint(x: 7.21, y: 6.63),
//            EILPoint(x: 7.21, y: 0),
//            EILPoint(x: 3.86, y: 0),
//            EILPoint(x: 3.86, y: 3.02),
//            EILPoint(x: 3.76, y: 3.02),
//            EILPoint(x: 3.76, y: 0)])
//
//        locationBuilder.addBeacon(withIdentifier: "554492cade78573e276c8ae7b990d739",
//                                  atBoundarySegmentIndex: 0, inDistance: 2.14, from: .leftSide)
//        locationBuilder.addBeacon(withIdentifier: "616895debbed85ee3551babca24fd70d",
//                                  atBoundarySegmentIndex: 1, inDistance: 1.0, from: .leftSide)
//        locationBuilder.addBeacon(withIdentifier: "89d4ef27c2d20e38436d20a70ca3d53e",
//                                  atBoundarySegmentIndex: 2, inDistance: 0.2, from: .leftSide)
//        locationBuilder.addBeacon(withIdentifier: "a28909a39d8324ab0b9fd458f8b1ba07",
//                                  atBoundarySegmentIndex: 4, inDistance: 0.6, from: .leftSide)
//        locationBuilder.addBeacon(withIdentifier: "f905c5bf3294a6d3b6873a90b7171926",
//                                  atBoundarySegmentIndex: 5, inDistance: 0.5, from: .leftSide)
//        locationBuilder.addBeacon(withIdentifier: "a6c80cf383f89b658286b40372d34002",
//                                  atBoundarySegmentIndex: 7, inDistance: 0.65, from: .leftSide)
//        locationBuilder.addBeacon(withIdentifier: "ea518ee5a0ac11366f18663d8d53df1a",
//                                  atBoundarySegmentIndex: 8, inDistance: 1.5, from: .leftSide)
//        locationBuilder.addBeacon(withIdentifier: "f3a7eac1c525c124a2d7d41c39c50c15",
//                                  atBoundarySegmentIndex: 9, inDistance: 0.1, from: .rightSide)
//        locationBuilder.addBeacon(withIdentifier: "5b0b1956d31ac6610180c4ab05dade2a",
//                                  atBoundarySegmentIndex: 12, inDistance: 1.3, from: .leftSide)
//        locationBuilder.addBeacon(withIdentifier: "f31220a8a0ec53e5a863fec022517011",
//                                  atBoundarySegmentIndex: 12, inDistance: 2.0, from: .rightSide)
//        locationBuilder.addBeacon(withIdentifier: "c6f74e60a00d9fa554520e7608a6922c",
//                                  atBoundarySegmentIndex: 13, inDistance: 1.77, from: .leftSide)
//        locationBuilder.addBeacon(withIdentifier: "5aa2c2586f276cb554e8284e7efb5336",
//                                  atBoundarySegmentIndex: 14, inDistance: 1.50, from: .leftSide)
//        locationBuilder.addBeacon(withIdentifier: "61081f0a5e8f76896892f8819f76b424",
//                                  atBoundarySegmentIndex: 16, inDistance: 1.5, from: .rightSide)
//        locationBuilder.addBeacon(withIdentifier: "ca0f99188ca1703ce876d0f6f001fb26",
//                                  atBoundarySegmentIndex: 17, inDistance: 1.2, from: .leftSide)
//        locationBuilder.addBeacon(withIdentifier: "6b2d8f41de2c170fd10c24a971773207",
//                                  atBoundarySegmentIndex: 17, inDistance: 1.2, from: .rightSide)
        
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

        let location = locationBuilder.build()!
        
        ESTConfig.setupAppID("createlocation-nvz", andAppToken: "6d80043433f478675e6b325e2d719f58")
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

