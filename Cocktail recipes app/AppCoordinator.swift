//
//  AppCoordinator.swift
//  Cocktail recipes app
//
//  Created by Artem Lugynets on 01.09.2022.
//

import Foundation
import UIKit

class AppCoordinator {
    private let window: UIWindow
    private let nav = UINavigationController()
    private let serviceHolder = ServiceHolder.shared.self
    
    private weak var appStartCoord: AppStartCoordinator?
    
    init(window: UIWindow) {
        self.window = window
        start()
    }
    
    private func start() {
        startFlow()
        startInitialServices()
    }
    
    private func startFlow() {
        window.rootViewController = nav
        window.makeKeyAndVisible()
        
        //debug for checkers screen
//        nav.isNavigationBarHidden = true
//        let coord = CheckersScreenCoord(navController: nav, anotherUserGUID: "Tester", transitions: nil)
//        coord.start()
//        return;
        
        nav.navigationBar.barStyle = .black
        nav.navigationBar.tintColor = .white
      
        enterApp()
}
    
    private func enterApp() {
        let coord = AppStartCoordinator(navController: nav, transitions: nil, serviceHolder: serviceHolder)
        coord.start()
        
        appStartCoord = coord
    }
    
}

extension AppCoordinator {
    
    private func startInitialServices() {
//        serviceHolder.add(BluetoothDiscoverServiceType.self, for: BluetoothDiscoverService())
    }
    
}
