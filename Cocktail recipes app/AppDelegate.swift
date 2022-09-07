//
//  AppDelegate.swift
//  Cocktail recipes app
//
//  Created by Artem Lugynets on 01.09.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window?.overrideUserInterfaceStyle = .light
        if let window = window {
            appCoordinator = AppCoordinator(window: window)
        }
        return true
    }
    
}

