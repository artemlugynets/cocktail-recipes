//
//  CocktailListViewModel.swift
//  Cocktail recipes app
//
//  Created by Artem Lugynets on 13.09.2022.
//

import Foundation

protocol CocktailListViewModelType {
    var category: String { get }
    func fetchCocktailList(completion: @escaping () -> Void)
    func getImageForCell(at indexPath: IndexPath, completion: @escaping (_ image: Data) -> Void) -> URLSessionDataTask?
    func getNumberOfCells() -> Int
    func getDrinkCellName(at indexPath: IndexPath) -> String
    func cellDidTap(at indexPath: IndexPath)
}

class CocktailListViewModel: CocktailListViewModelType {
    
    let category: String
    weak var coordinator: MainCoordinator?
    private let typeOfCocktails: TypeOfCocktailsList
    private var cocktailList: CocktailsList?
    private var network: NetworkManagerType?
    
    init(for category: String, typeOfList: TypeOfCocktailsList) {
        self.category = category
        self.typeOfCocktails = typeOfList
        self.network = ServiceHolder.shared.get(by: NetworkManagerType.self)
    }
    
    func fetchCocktailList(completion: @escaping () -> Void) {
        switch typeOfCocktails {
        case .category:
            network?.fetchList(for: category) { list in
                self.cocktailList = list
                completion()
            }
        case .ingredient:
            network?.fetchIngredientList(for: category) { list in
                self.cocktailList = list
                completion()
            }
        }
    }
    
    func getImageForCell(at indexPath: IndexPath, completion: @escaping (Data) -> Void) -> URLSessionDataTask? {
        guard let url = URL(string: (cocktailList?.drinks[indexPath.row].strDrinkThumb ?? "") + "/preview") else {
            print("No URL")
            return nil
        }
        let task = network?.fetchImage(from: url) { data in
            completion(data)
        }
        return task
    }
    
    func getNumberOfCells() -> Int {
        cocktailList?.drinks.count ?? 0
    }
    
    func getDrinkCellName(at indexPath: IndexPath) -> String {
        cocktailList?.drinks[indexPath.row].strDrink ?? ""
    }
    
    func cellDidTap(at indexPath: IndexPath) {
        
    }
}
