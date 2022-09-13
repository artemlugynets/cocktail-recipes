//
//  AppStartViewModel.swift
//  Cocktail recipes app
//
//  Created by Artem Lugynets on 01.09.2022.
//

import Foundation

protocol SearchViewModelType {
    func getRequest()
}

class SearchViewModel: SearchViewModelType {
    private var networkService: NetworkManagerType
    
    var categories: Categories?
    
    // example of service init
//    private let analyticsService = AnalyticsService.shared
    
    init() {
        networkService = ServiceHolder.shared.get(by: NetworkManagerType.self)
//        self.remoteConfigService = serviceHolder.get(by: RemoteConfigType.self)
    }
    
    func getRequest() {
        networkService.fetchCategories { drinks in
            self.categories = self.sortedCategory(from: drinks)
            print(self.categories)
        }
    }
}

extension SearchViewModel {
    private func sortedCategory(from categories: Categories) -> Categories {
        let drinks = categories.drinks.sorted { $0.strCategory < $1.strCategory }
        return Categories(drinks: drinks)
    }
}
