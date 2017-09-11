//
//  AppDelegate.swift
//  blesson3
//
//  Created by Oscar Rodriguez Garrucho on 10/9/17.
//  Copyright © 2017 Oscar Rodriguez Garrucho. All rights reserved.
//

import UIKit
import GooglePlaces
import CoreLocation
import Permission


struct CoreData {
    static var places = [Place]()

}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    var locationManager = CLLocationManager()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSPlacesClient.provideAPIKey("AIzaSyCFUCj8MEQTCn6pAa4y2s-mjSkYdsS1GBQ")
        
        let permission: Permission = .locationAlways
        
        print(permission.status)
        
        permission.request { status in
            switch status {
            case .authorized:    print("authorized")
            case .denied:        print("denied")
            case .disabled:      print("disabled")
            case .notDetermined: print("not determined")
            }
        }
        
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.startMonitoringSignificantLocationChanges()
        
        
        return true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("significant location change")
        
        if let lastLocation = locations.last {

            ECProgressView.shared.hideProgressView()
            UserDefaults.standard.set("\(lastLocation.coordinate.latitude)", forKey: "latitude")
            UserDefaults.standard.set("\(lastLocation.coordinate.longitude)", forKey: "longitude")
            print("Location Updated in AppDelegare! lat: \(lastLocation.coordinate.latitude), lng:\(lastLocation.coordinate.longitude)")
        }
        
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

