//
//  AppDelegate.swift
//  Swift-TableView-Example
//
//
//  Created by Mahi Velu on 12/26/2017.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        LocalDatabase.sharedInstance.methodToCreateDatabase()
        return true
    }
}
