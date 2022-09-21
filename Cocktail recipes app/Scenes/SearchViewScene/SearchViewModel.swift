//
//  AppStartViewModel.swift
//  Cocktail recipes app
//
//  Created by Artem Lugynets on 01.09.2022.
//

import Foundation

protocol SearchViewModelType: TableViewModelType {
    func searchBarTextDidChange(text: String)
//    var reloadTable: (() -> Void)? { get set }
}

class SearchViewModel: SearchViewModelType {
    
    private var network: NetworkManagerType = ServiceHolder.shared.get(by: NetworkManagerType.self)
    
    private var cocktailsList: CocktailSearch?
    weak var coordinator: MainCoordinator?
    weak var searchVC: SearchVCDelegate?
    
//    init() {
//        network = ServiceHolder.shared.get(by: NetworkManagerType.self)
//    }
    
    func fetchDrink(completion: @escaping () -> Void) {
        completion()
    }
    
    func getNavigationTitle() -> String {
        ""
    }
    
    func getNumberOfRows() -> Int {
        cocktailsList?.drinks?.count ?? 0
    }
    
    func getDrinkCellCategory(at index: IndexPath) -> String {
        cocktailsList?.drinks?[index.row].strDrink ?? ""
    }
    
    func cellDidSelect(at index: IndexPath) {
        if let cocktailId = cocktailsList?.drinks?[index.row].idDrink {
            coordinator?.openSingleCocktailView(for: cocktailId)
        }
    }
}

extension SearchViewModel {
    func searchBarTextDidChange(text: String) {
        let searchText = getSearchText(from: text)
        if text.isEmpty {
            cocktailsList = nil
            searchVC?.tableViewReload()
//            self.reloadTable()
        } else {
            if text.count == 1 {
                network.fetchSearchText(for: searchText, from: .searchOneSymbol) { list in
                    self.cocktailsList = list
//                    self.reloadTable?()
                    self.searchVC?.tableViewReload()
                }
            } else {
                network.fetchSearchText(for: searchText, from: .searchTwoAndMoreSymbols) { list in
                    self.cocktailsList = list
//                    self.reloadTable?()
                    self.searchVC?.tableViewReload()
                }
            }
        }
    }
    
    private func getSearchText(from text: String) -> String {
        return text
            .replacingOccurrences(of: " ", with: "+")
            .lowercased()
            .applyingTransform(.toLatin, reverse: false)?
            .applyingTransform(.stripDiacritics, reverse: false) ?? ""
    }
}
