//
//  SingleCocktailViewController.swift
//  Cocktail recipes app
//
//  Created by Artem Lugynets on 14.09.2022.
//

import Foundation
import UIKit

protocol SingleCocktailType {
    var cocktailName: NSAttributedString? { get set }
    var cocktailDetails: NSAttributedString? { get set }
    var cocktailImageData: Data? { get set }
}

class SingleCocktailViewController: UIViewController, SingleCocktailType {
    
    var cocktailName: NSAttributedString? {
        didSet {
            cocktailNameLabel.attributedText = cocktailName
        }
    }
    
    var cocktailDetails: NSAttributedString? {
        didSet {
            textView.attributedText = cocktailDetails
        }
    }
    
    var cocktailImageData: Data? {
        didSet {
            drinkImage.image = UIImage(data: cocktailImageData ?? Data())
            placeholderImage.isHidden = true
        }
    }
    
    private lazy var cocktailNameLabel: UILabel = {
        let label = UILabel()
        let attributes = [
            NSAttributedString.Key.backgroundColor: UIColor.lightGray,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30),
            NSAttributedString.Key.foregroundColor: UIColor.lightGray
        ]
        let placeHolderText = NSAttributedString(string: "Placeholder", attributes: attributes)
        label.attributedText = placeHolderText
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        return label
    }()
    
    private lazy var discriptionView: UIScrollView = {
        let discriptionView = UIScrollView()
        discriptionView.isScrollEnabled = true
        discriptionView.showsVerticalScrollIndicator = false
        return discriptionView
    }()
    
    private lazy var insideView = UIView()
    
    private lazy var textView: UILabel = {
        let textView = UILabel()
        textView.numberOfLines = 0
        textView.adjustsFontSizeToFitWidth = true
        textView.sizeToFit()
        return textView
    }()
    
    private lazy var drinkImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .placeholderText
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.borderWidth = 1
        return image
    }()
    
    private lazy var placeholderImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "placeholder")
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
//        view.addSubview(drinkImage)
        view.addSubview(discriptionView)
        drinkImage.addSubview(placeholderImage)
        discriptionView.addSubview(insideView)
        insideView.addSubview(drinkImage)
        insideView.addSubview(cocktailNameLabel)
        insideView.addSubview(textView)
//        setupConstraint()
        setupImageInScrollView()
    }
    
    
}

extension SingleCocktailViewController {
    private func setupConstraint() {
        drinkImage.translatesAutoresizingMaskIntoConstraints = false
        discriptionView.translatesAutoresizingMaskIntoConstraints = false
        insideView.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        cocktailNameLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderImage.translatesAutoresizingMaskIntoConstraints = false
        let margins = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            drinkImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            drinkImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            drinkImage.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.9),
            drinkImage.heightAnchor.constraint(equalTo: drinkImage.widthAnchor),
            
            insideView.topAnchor.constraint(equalTo: discriptionView.topAnchor),
            insideView.leftAnchor.constraint(equalTo: discriptionView.leftAnchor),
            insideView.bottomAnchor.constraint(equalTo: discriptionView.bottomAnchor),
            insideView.rightAnchor.constraint(equalTo: discriptionView.rightAnchor),
            insideView.widthAnchor.constraint(equalTo: discriptionView.widthAnchor),
            insideView.heightAnchor.constraint(equalToConstant: 400),

            cocktailNameLabel.topAnchor.constraint(equalTo: insideView.topAnchor),
            cocktailNameLabel.leftAnchor.constraint(equalTo: insideView.leftAnchor, constant: 16),
            cocktailNameLabel.rightAnchor.constraint(equalTo: insideView.rightAnchor, constant: -16),
            
            textView.topAnchor.constraint(equalTo: cocktailNameLabel.bottomAnchor, constant: 10),
            textView.leftAnchor.constraint(equalTo: insideView.leftAnchor, constant: 16),
            textView.rightAnchor.constraint(equalTo: insideView.rightAnchor, constant: -16),
            textView.heightAnchor.constraint(lessThanOrEqualToConstant: 350),
            
            placeholderImage.centerXAnchor.constraint(equalTo: drinkImage.centerXAnchor),
            placeholderImage.centerYAnchor.constraint(equalTo: drinkImage.centerYAnchor),
            placeholderImage.heightAnchor.constraint(equalToConstant: 150),
            placeholderImage.widthAnchor.constraint(equalToConstant: 150),
            
            discriptionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            discriptionView.topAnchor.constraint(equalTo: drinkImage.bottomAnchor, constant: 10),
            discriptionView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
//            discriptionView.heightAnchor.constraint(equalToConstant: 1000)
        ])
    }
    
    private func setupImageInScrollView() {
        drinkImage.translatesAutoresizingMaskIntoConstraints = false
        discriptionView.translatesAutoresizingMaskIntoConstraints = false
        insideView.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        cocktailNameLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderImage.translatesAutoresizingMaskIntoConstraints = false
//        let margins = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            discriptionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            discriptionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            discriptionView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.9),
            discriptionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            insideView.topAnchor.constraint(equalTo: discriptionView.topAnchor, constant: 0),
            insideView.leftAnchor.constraint(equalTo: discriptionView.leftAnchor),
            insideView.bottomAnchor.constraint(equalTo: discriptionView.bottomAnchor),
            insideView.rightAnchor.constraint(equalTo: discriptionView.rightAnchor),
            insideView.widthAnchor.constraint(equalTo: discriptionView.widthAnchor),
            insideView.heightAnchor.constraint(equalToConstant: view.bounds.height + 150),
            
            drinkImage.centerXAnchor.constraint(equalTo: insideView.centerXAnchor),
            drinkImage.topAnchor.constraint(equalTo: insideView.topAnchor, constant: 0),
            drinkImage.widthAnchor.constraint(equalTo: insideView.widthAnchor),
            drinkImage.heightAnchor.constraint(equalTo: drinkImage.widthAnchor),

            cocktailNameLabel.topAnchor.constraint(equalTo: drinkImage.bottomAnchor, constant: 10),
            cocktailNameLabel.leftAnchor.constraint(equalTo: insideView.leftAnchor, constant: 16),
            cocktailNameLabel.rightAnchor.constraint(equalTo: insideView.rightAnchor, constant: -16),
            
            textView.topAnchor.constraint(equalTo: cocktailNameLabel.bottomAnchor, constant: 10),
            textView.leftAnchor.constraint(equalTo: insideView.leftAnchor, constant: 16),
            textView.rightAnchor.constraint(equalTo: insideView.rightAnchor, constant: -16),
            textView.heightAnchor.constraint(lessThanOrEqualToConstant: 350),
            
            placeholderImage.centerXAnchor.constraint(equalTo: drinkImage.centerXAnchor),
            placeholderImage.centerYAnchor.constraint(equalTo: drinkImage.centerYAnchor),
            placeholderImage.heightAnchor.constraint(equalToConstant: 150),
            placeholderImage.widthAnchor.constraint(equalToConstant: 150),

//            discriptionView.heightAnchor.constraint(equalToConstant: 1000)
        ])
    }
}
