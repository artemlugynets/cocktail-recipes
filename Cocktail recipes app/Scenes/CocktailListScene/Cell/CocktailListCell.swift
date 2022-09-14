//
//  CocktailListCell.swift
//  Cocktail recipes app
//
//  Created by Artem Lugynets on 13.09.2022.
//

import Foundation
import UIKit

class CocktailListCell: UICollectionViewCell {
    
    lazy var cocktailImageView: UIImageView = {
        let cocktailImageView = UIImageView()
        cocktailImageView.layer.cornerRadius = 7
        cocktailImageView.clipsToBounds = true
        return cocktailImageView
    }()
    
    lazy var cocktailNameLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.textColor = .white
        let font = UIFont(name: "AvenirNextCondensed-DemiBold", size: 15)
        textLabel.font = font
        return textLabel
    }()
    
    var task: URLSessionDataTask?
    
    override func prepareForReuse() {
        cocktailImageView.image = nil
        cocktailNameLabel.text = ""
        if let task = task {
            task.cancel()
        }
        task = nil
    }
    
    func setupCollectionViewCell() {
        addSubview(cocktailNameLabel)
        addSubview(cocktailImageView)
        
        self.contentView.layer.cornerRadius = 15
        self.contentView.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 1.3
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        
        cocktailImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cocktailImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            cocktailImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            cocktailImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            cocktailImageView.heightAnchor.constraint(equalTo: cocktailImageView.widthAnchor)
        ])
        
        cocktailNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cocktailNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: self.layer.bounds.height * -0.045),
            cocktailNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            cocktailNameLabel.widthAnchor.constraint(lessThanOrEqualToConstant: self.layer.bounds.width * 0.9)
        ])
    }
}
