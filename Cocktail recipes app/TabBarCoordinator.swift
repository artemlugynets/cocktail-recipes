//
//  TabBarCoordinator.swift
//  Cocktail recipes app
//
//  Created by Artem Lugynets on 10.09.2022.
//

import Foundation
import UIKit

protocol MainCoordinator: AnyObject {
    var tabBarController: UITabBarController? { get set }
    func start()
//    func openCoctailList(for category: String, typeOfCocktailList: TypeOfCocktailsList)
}

class TabBarCoordinator: MainCoordinator {
    
    var tabBarController: UITabBarController?
    
    func start() {
        tabBarController?.tabBar.backgroundColor = .white
        tabBarController?.tabBar.tintColor = .blue
        tabBarController?.tabBar.isTranslucent = true
        
//        let categoryVC = returnCategoryList()
//        categoryVC.tabBarItem = UITabBarItem(title: "Category", image: UIImage(systemName: "list.dash"), tag: 0)
        
//        let alcoVC = returnAlcoList()
//        alcoVC.tabBarItem = UITabBarItem(title: "Ingredients", image: UIImage(systemName: "drop"), tag: 1)
//
//        let searchVC = returnSearchVC()
//        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass.circle.fill"), tag: 2)
        
//        let favouritesVC = returnFavouritesVC()
//
//        tabBarController?.viewControllers = [categoryVC, alcoVC, searchVC]
    }
    
//    private func returnMainList() -> UIViewController {
//
//    }
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
//    func openCoctailList(for category: String, typeOfCocktailList: TypeOfCocktailsList) {
//        let coctailListVC = CocktailListViewController()
//        let cocktailListVM = CocktailListViewModel(for: category, typeOfList: typeOfCocktailList)
//        cocktailListVM.coordinator = self
//        coctailListVC.cocktailListViewModel = cocktailListVM
//        let selectedVC = tabBarController?.selectedViewController
//        guard let selectedVC = selectedVC as? CustomNavigationController else { return }
//        selectedVC.pushViewController(coctailListVC, animated: true)
//    }
    
    
}
