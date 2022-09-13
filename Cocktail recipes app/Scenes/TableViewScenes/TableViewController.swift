//
//  TableViewController.swift
//  Cocktail recipes app
//
//  Created by Artem Lugynets on 10.09.2022.
//

import UIKit

class TableViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        // MARK: CARE THIS LINE
        tableView.contentInset.bottom = .zero
        
        tableView.backgroundColor = .blue
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.separatorColor = .black
        return tableView
    }()
    
    var tableViewModel: TableViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = tableViewModel?.getNavigationTitle()
        tableView.delegate = self
        tableView.dataSource = self
        view.insetsLayoutMarginsFromSafeArea = true
        view.backgroundColor = .blue
        view.addSubview(tableView)
        tableViewModel?.fetchDrink { [unowned self] in
            self.tableView.reloadData()
        }
    }
}


extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableViewModel?.getNumberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = tableViewModel?.getDrinkCellCategory(at: indexPath)
        
        content.textProperties.color = .black
        content.textProperties.font = .preferredFont(forTextStyle: .title2, compatibleWith: .none)
        cell.contentConfiguration = content
        cell.backgroundColor = .blue
        
        let bgColor = UIView()
        bgColor.backgroundColor = .systemBlue
        cell.selectedBackgroundView = bgColor
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewModel?.cellDidSelect(at: indexPath)
    }
    
}
