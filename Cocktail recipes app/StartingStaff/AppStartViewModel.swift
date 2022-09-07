//
//  AppStartViewModel.swift
//  Cocktail recipes app
//
//  Created by Artem Lugynets on 01.09.2022.
//

import Foundation

protocol AppStartViewModelType {
    func getRequest()
}

class AppStartViewModel: AppStartViewModelType {
    private let coordinator: AppStartCoordinatorType
    private var networkService: NetworkManagerType
    
    var categories: Categories?
    
    // example of service init
//    private let analyticsService = AnalyticsService.shared
    
    init(_ coordinator: AppStartCoordinatorType) {
        self.coordinator = coordinator
        networkService = ServiceHolder.shared.get(by: NetworkManagerType.self)
//        self.remoteConfigService = serviceHolder.get(by: RemoteConfigType.self)
    }
    
    func getRequest() {
        networkService.fetchCategories { drinks in
            self.categories = self.sortedCategory(from: drinks)
            print(self.categories)
        }
    }
    
    private func sortedCategory(from categories: Categories) -> Categories {
        let drinks = categories.drinks.sorted { $0.strCategory < $1.strCategory }
        return Categories(drinks: drinks)
    }
}
