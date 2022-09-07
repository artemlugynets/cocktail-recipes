//
//  AppStartViewController.swift
//  Cocktail recipes app
//
//  Created by Artem Lugynets on 01.09.2022.
//

import Foundation
import UIKit

class AppStartViewController: UIViewController {
    
    var viewModel: AppStartViewModelType?
    
    override func viewDidLoad() {
        guard let viewModel = viewModel else { return }
        viewModel.getRequest()
    }
}
