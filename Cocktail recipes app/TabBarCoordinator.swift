//
//  TabBarCoordinator.swift
//  Cocktail recipes app
//
//  Created by Artem Lugynets on 10.09.2022.
//

import Foundation
import UIKit

protocol MainCoordinator: AnyObject {
    var myTabBarController: UITabBarController? { get set }
    func start()
    func openCoctailList(for category: String, typeOfCocktailList: TypeOfCocktailsList)
    func openSingleCocktailView(for id: String)
}

class TabBarCoordinator: MainCoordinator {
    
    var myTabBarController: UITabBarController?
    
    private var serviceHolder: ServiceHolder
    private var navigationController: CustomNavigationController
    
    init(navigationController: CustomNavigationController, service: ServiceHolder) {
        self.serviceHolder = service
        self.navigationController = navigationController
    }
    
    func start() {
        myTabBarController?.tabBar.backgroundColor = .white
        myTabBarController?.tabBar.tintColor = .blue
        myTabBarController?.tabBar.isTranslucent = true
        
        let categoryVC = returnCategoriesList()
        categoryVC.tabBarItem = UITabBarItem(title: "Categories", image: UIImage(systemName: "list.dash"), tag: 0)
        
        let ingredientsVC = returnIngredientsList()
        ingredientsVC.tabBarItem = UITabBarItem(title: "Ingredients", image: UIImage(systemName: "drop"), tag: 1)

        let searchVC = returnSearchViewController()
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass.circle.fill"), tag: 2)
        
//        let favouritesVC = returnFavouritesVC()

        myTabBarController?.viewControllers = [categoryVC, ingredientsVC, searchVC]
    }
    
    private func returnCategoriesList() -> UIViewController {
        let navigationController = CustomNavigationController()
        let categoryVC = TableViewController()
        let tableViewModel = TableViewModel(typeOfTable: .categories)
        tableViewModel.coordinator = self
        categoryVC.tableViewModel = tableViewModel
        navigationController.viewControllers = [categoryVC]
        return navigationController
    }
    
    private func returnIngredientsList() -> UIViewController {
        let navigationController = CustomNavigationController()
        let ingredientsVC = TableViewController()
        let tableViewModel = TableViewModel(typeOfTable: .ingredients)
        tableViewModel.coordinator = self
        ingredientsVC.tableViewModel = tableViewModel
        navigationController.viewControllers = [ingredientsVC]
        return navigationController
    }

    private func returnSearchViewController() -> UIViewController {
        let navigationController = CustomNavigationController()
        let searchVC = SearchViewController()
        let tableViewModel = SearchViewModel()
        tableViewModel.coordinator = self
        tableViewModel.searchVC = searchVC
        searchVC.searchViewModel = tableViewModel
        navigationController.viewControllers = [searchVC]
        return navigationController
    }

//    private func returnFavouritesViewController() -> UIViewController {
//
//    }

    func openCoctailList(for category: String, typeOfCocktailList: TypeOfCocktailsList) {
        let coctailListVC = CocktailListViewController()
        let cocktailListVM = CocktailListViewModel(for: category, typeOfList: typeOfCocktailList)
        cocktailListVM.coordinator = self
        coctailListVC.cocktailListViewModel = cocktailListVM
        let selectedVC = myTabBarController?.selectedViewController
        guard let selectedVC = selectedVC as? CustomNavigationController else { return }
        selectedVC.pushViewController(coctailListVC, animated: true)
    }
    
    func openSingleCocktailView(for id: String) {
        let drinkVC = SingleCocktailViewController()
        let drinkVM = SingleCocktailViewModel(for: id)
        drinkVM.coordinator = self
        drinkVM.singleDrinkSceneProtocol = drinkVC
        let selectedVC = myTabBarController?.selectedViewController
        guard let selectedVC = selectedVC as? CustomNavigationController else { return }
        selectedVC.pushViewController(drinkVC, animated: true)
    }
}
