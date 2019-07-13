//
//  AppDelegate.swift
//  iOSCleanArchitecture
//
//  Created by Lee YoungJu on 2019. 7. 13..
//  Copyright © 2019년 Lee YoungJu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigator: BaseNavigatorInterface?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ApplicationContext.initialize(.test)
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationViewController = UINavigationController(rootViewController: UIViewController())
        navigationViewController.isNavigationBarHidden = true
        window.rootViewController = navigationViewController
        navigator = AllPostNavigator()
        navigator?.pushViewController(from: navigationViewController.topViewController!)
        
        self.window = window
        self.window?.makeKeyAndVisible()
        Log.setupDDLog()
        return true
    }
}

