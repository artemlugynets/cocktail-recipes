//
//  AppStartViewModel.swift
//  Cocktail recipes app
//
//  Created by Artem Lugynets on 01.09.2022.
//

import Foundation

protocol AppStartViewModelType {
    
}

class AppStartViewModel: AppStartViewModelType {
    private let coordinator: AppStartCoordinator
    
    // example of service init
//    private let analyticsService = AnalyticsService.shared
    
    init(_ coordinator: AppStartCoordinator, serviceHolder: ServiceHolder) {
        self.coordinator = coordinator
//        self.remoteConfigService = serviceHolder.get(by: RemoteConfigType.self)
        
    }
}
