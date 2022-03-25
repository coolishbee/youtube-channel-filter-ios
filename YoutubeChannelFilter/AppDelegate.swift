//
//  AppDelegate.swift
//  YoutubeChannelFilter
//
//  Created by coolishbee on 2022/03/03.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //window = UIWindow(frame: UIScreen.main.bounds)
        //window?.rootViewController = ViewController()
        //window?.makeKeyAndVisible()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        print("WillResignActive")
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("DidEnterBackground")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        print("WillEnterForeground")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        print("DidBecomeActive")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        print("WillTerminate")
        //self.saveContext()
    }

    
    
}

