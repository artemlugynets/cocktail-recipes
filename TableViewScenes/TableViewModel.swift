//
//  TableViewModel.swift
//  Cocktail recipes app
//
//  Created by Artem Lugynets on 10.09.2022.
//

import Foundation

protocol TableViewModelType: AnyObject {
    
}

class TableViewModel: TableViewModelType {
    
    
    var coordinator: MainCoordinator?
    
    private var typeOfTable: TypeOfTable
    private var ingredients: Ingredients?
    private var categories: Categories?
    
    init(typeOfTable: TypeOfTable) {
        self.typeOfTable = typeOfTable
    }
    
    func fetchDrink() {
        switch typeOfTable {
        case .ingredients:
            
        case .categories:
            <#code#>
        }
    }
}
