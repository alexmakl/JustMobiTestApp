//
//  AppDelegate.swift
//  JustMobiTestApp
//
//  Created by Alexander on 11.07.2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = MainViewController()
        let nc = UINavigationController(rootViewController: vc)
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
        return true
    }
}

