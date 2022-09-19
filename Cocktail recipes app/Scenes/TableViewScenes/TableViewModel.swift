//
//  TableViewModel.swift
//  Cocktail recipes app
//
//  Created by Artem Lugynets on 10.09.2022.
//

import Foundation

protocol TableViewModelType: AnyObject {
    func fetchDrink(completion: @escaping () -> Void)
    func getNavigationTitle() -> String
    func getNumberOfRows() -> Int
    func getDrinkCellCategory(at index: IndexPath) -> String
    func cellDidSelect(at index: IndexPath)
}

class TableViewModel: TableViewModelType {
    
    
    var coordinator: MainCoordinator?
    
    private var typeOfTable: TypeOfTable
    private var ingredients: Ingredients?
    private var categories: Categories?
    private var network: NetworkManagerType
    
    init(typeOfTable: TypeOfTable) {
        self.typeOfTable = typeOfTable
        self.network = ServiceHolder.shared.get(by: NetworkManagerType.self)
    }
    
    func fetchDrink(completion: @escaping () -> Void) {
        switch typeOfTable {
        case .ingredients:
            network.fetchIngredients { drinks in
                self.ingredients = self.sortedIngredient(from: drinks)
                completion()
            }
        case .categories:
            network.fetchCategories { drinks in
                self.categories = self.sortedCategory(from: drinks)
                completion()
            }
        }
    }
    
    func getNavigationTitle() -> String {
        switch typeOfTable {
        case .ingredients:
            return "INGREDIENTS"
        case .categories:
            return "CATEGORIES"
        }
    }
    
    func getNumberOfRows() -> Int {
        switch typeOfTable {
        case .ingredients:
            return ingredients?.drinks.count ?? 0
        case .categories:
            return categories?.drinks.count ?? 0
        }
    }
    
    func getDrinkCellCategory(at index: IndexPath) -> String {
        switch typeOfTable {
        case .ingredients:
            return ingredients?.drinks[index.row].strIngredient1 ?? ""
        case .categories:
            return categories?.drinks[index.row].strCategory ?? ""
        }
    }
    
    func cellDidSelect(at index: IndexPath) {
        switch typeOfTable {
        case .ingredients:
            let title = ingredients?.drinks[index.row].strIngredient1 ?? "Tequila"
            coordinator?.openCoctailList(for: title, typeOfCocktailList: .ingredient)
        case .categories:
            let title = categories?.drinks[index.row].strCategory ?? "Cocktail"
            coordinator?.openCoctailList(for: title, typeOfCocktailList: .category)
        }
    }
}

extension TableViewModel {
    private func sortedCategory(from categories: Categories) -> Categories {
        let drinks = categories.drinks.sorted { $0.strCategory < $1.strCategory }
        return Categories(drinks: drinks)
    }
    private func sortedIngredient(from ingredients: Ingredients) -> Ingredients {
        let drinks = ingredients.drinks.sorted { $0.strIngredient1 < $1.strIngredient1 }
        return Ingredients(drinks: drinks)
    }
}
