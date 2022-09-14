//
//  CocktailListViewController.swift
//  Cocktail recipes app
//
//  Created by Artem Lugynets on 13.09.2022.
//

import Foundation
import UIKit

class CocktailListViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width / 2
        let height = width * 1.25
        let insets = width / 8
        layout.sectionInset = UIEdgeInsets(top: insets, left: insets, bottom: insets, right: insets)
        layout.itemSize = CGSize(width: width, height: height)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        collectionView.contentInset.bottom = tabBarController?.tabBar.frame.height ?? 0
        collectionView.register(CocktailListCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = .blue
        return collectionView
    }()
    
    var cocktailListViewModel: CocktailListViewModelType? {
        didSet {
            cocktailListViewModel?.fetchCocktailList { [unowned self] in
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        navigationItem.title = cocktailListViewModel?.category
        view.addSubview(collectionView)
    }
}

extension CocktailListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cocktailListViewModel?.getNumberOfCells() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CocktailListCell else { return .init() }
        cell.setupCollectionViewCell()
        cell.cocktailNameLabel.text = cocktailListViewModel?.getDrinkCellName(at: indexPath)
        cell.task = cocktailListViewModel?.getImageForCell(at: indexPath) { image in
            cell.cocktailImageView.image = UIImage(data: image)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let viewModel = cocktailListViewModel else { return false }
        viewModel.cellDidTap(at: indexPath)
        return true
    }
}
