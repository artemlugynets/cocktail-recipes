//
//  CustomNavigationController.swift
//  Cocktail recipes app
//
//  Created by Artem Lugynets on 10.09.2022.
//

import Foundation
import UIKit

class CustomNavigationController: UINavigationController {
    init() {
        super.init(nibName: nil, bundle: nil)
        navigationBar.prefersLargeTitles = true
        navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar.barTintColor = .blue
        navigationBar.tintColor = .white
        modalPresentationStyle = .custom
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
}
