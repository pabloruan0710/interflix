//
//  FIlmeCollectionViewCell.swift
//  InterFlix
//
//  Created by Pablo Ruan Ribeiro Silva  on 05/01/22.
//

import UIKit

class FIlmeCollectionViewCell: UICollectionViewCell {
    
    private lazy var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.accessibilityIdentifier = "viewContainer"
        return view
    }()

    lazy var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        return loader
    }()
    
    lazy var imagePoster: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.accessibilityIdentifier = "imagePoster"
        return image
    }()
    
    lazy var containerPoster: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.accessibilityIdentifier = "containerPoster"
        return view
    }()
    
    class func identifier() -> String {
        return String(describing: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        buildViewHeirarchy()
        addConstraints()
    }
    
    private func buildViewHeirarchy() {
        contentView.addSubview(view)
        view.addSubview(containerPoster)
        containerPoster.addSubview(imagePoster)
        containerPoster.addSubview(loader)
    }
    
    private func addConstraints() {
        
        let constraintsView = [
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        let constraintsContainerImage = [
            containerPoster.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerPoster.topAnchor.constraint(equalTo: view.topAnchor, constant: 2),
            containerPoster.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerPoster.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -2)
        ]
        
        let constraintsImage = [
            imagePoster.leadingAnchor.constraint(equalTo: containerPoster.leadingAnchor),
            imagePoster.topAnchor.constraint(equalTo: containerPoster.topAnchor),
            imagePoster.trailingAnchor.constraint(equalTo: containerPoster.trailingAnchor),
            imagePoster.bottomAnchor.constraint(equalTo: containerPoster.bottomAnchor)
        ]
        
        let constraintsLoader = [
            loader.centerYAnchor.constraint(equalTo: containerPoster.centerYAnchor),
            loader.centerXAnchor.constraint(equalTo: containerPoster.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(constraintsView)
        NSLayoutConstraint.activate(constraintsContainerImage)
        NSLayoutConstraint.activate(constraintsImage)
        NSLayoutConstraint.activate(constraintsLoader)
    }
    
    func updateFilme(_ filme: Filme) {
        self.loader.startAnimating()
        
        API.downloadImage(filme.getUrlPoster()) { [weak self] status, image in
            DispatchQueue.main.async {
                self?.imagePoster.image = image
                self?.loader.stopAnimating()
            }
        }
    }
}
