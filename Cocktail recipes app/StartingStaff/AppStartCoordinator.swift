//
//  AppStartCoordinator.swift
//  Cocktail recipes app
//
//  Created by Artem Lugynets on 01.09.2022.
//

import Foundation
import UIKit

protocol AppStartCoordinatorTransitions: AnyObject {}

protocol AppStartCoordinatorType {
    
}

class AppStartCoordinator {
    private weak var controller = Storyboard.main.controller(withClass: AppStartViewController.self)
    private weak var navController: UINavigationController?
    private weak var transitions: AppStartCoordinatorTransitions?
    private var serviceHolder: ServiceHolder
    
    init(navController: UINavigationController?, transitions: AppStartCoordinatorTransitions?, serviceHolder: ServiceHolder) {
        self.navController = navController
        self.transitions = transitions
        self.serviceHolder = serviceHolder
        controller?.viewModel = AppStartViewModel(self, serviceHolder: serviceHolder)
    }
    
    deinit {
        print("GamesMenuCoord - deinit")
    }
    
    func start() {
        print("NAV CONTROLLER IS USED")
        guard let controller = controller else { return }
        navController?.setViewControllers([controller], animated: true)
    }
}
