//
//  AppDelegate.swift
//  LongAssignment
//
//  Created by Solo on 20/03/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordiantor: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        appCoordiantor = AppCoordinator(window: window!,
                                        networkCheckService: NetworkCheckService())
        appCoordiantor.start()
        return true
    }

}

