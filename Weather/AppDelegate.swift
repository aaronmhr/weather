//
//  AppDelegate.swift
//  Weather
//
//  Created by Aaron Huánuco on 01/06/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
}

private extension AppDelegate {
    private func setMainScreen(viewController: UIViewController) {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.set(rootViewController: viewController)
    }
}

