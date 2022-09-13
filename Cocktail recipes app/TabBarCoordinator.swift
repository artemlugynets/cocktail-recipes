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
//
//        let searchVC = returnSearchVC()
//        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass.circle.fill"), tag: 2)
        
//        let favouritesVC = returnFavouritesVC()
//
//        tabBarController?.viewControllers = [categoryVC, alcoVC, searchVC]
    }
    
    private func returnCategoriesList() -> UIViewController {

    }
    
    private func returnIngredientsList() -> UIViewController {
        
    }
//
//    private func returnSearchViewController() -> UIViewController {
//        let navigationController = CustomNavigationController()
//        let searchVC = SearchTableViewController()
//        let tableViewModel = SearchViewModel()
//        tableViewModel.coordinator = self
//        tableViewModel.searchVC = searchVC
//        searchVC.searchViewModel = tableViewModel
//        navigationController.viewControllers = [searchVC]
//        return navigationController
//    }
//
//    private func returnFavouritesViewController() -> UIViewController {
//
//    }
//
    func openCoctailList(for category: String, typeOfCocktailList: TypeOfCocktailsList) {
        let coctailListVC = CocktailListViewController()
        let cocktailListVM = CocktailListViewModel(for: category, typeOfList: typeOfCocktailList)
        cocktailListVM.coordinator = self
        coctailListVC.cocktailListViewModel = cocktailListVM
        let selectedVC = myTabBarController?.selectedViewController
        guard let selectedVC = selectedVC as? CustomNavigationController else { return }
        selectedVC.pushViewController(coctailListVC, animated: true)
    }
    
    
}
