//
//  TableViewController.swift
//  Cocktail recipes app
//
//  Created by Artem Lugynets on 10.09.2022.
//

import Foundation
import UIKit

class TableViewController: UIViewController {
    
    var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableView.contentInset.bottom = tabBarController?.tabBar.frame.height ?? 0
        tableView.backgroundColor = .blue
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.separatorColor = .black
        return tableView
    }()
    
    var tableViewModel: TableViewModelType?
}
