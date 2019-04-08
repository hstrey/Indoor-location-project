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
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var positions = ""
    var proximityObserver: ProximityObserver!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        DropboxClientsManager.setupWithAppKey("ntx5fdghd485naq")
        
        let cloudCredentials = CloudCredentials(appID: "closecontactpink-4ry",
                                                appToken: "9c4ed6ee53ebe0e900afa0cf5ba211a6")
        
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

