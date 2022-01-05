//
//  CategoriaTableViewCell.swift
//  InterFlix
//
//  Created by Pablo Ruan Ribeiro Silva  on 05/01/22.
//

import UIKit

class CategoriaTableViewCell: UITableViewCell {
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        flow.minimumLineSpacing = 10
        flow.minimumInteritemSpacing = 0
        return flow
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FIlmeCollectionViewCell.self, forCellWithReuseIdentifier: FIlmeCollectionViewCell.identifier())
        return collectionView
    }()
    
    private var filmes: [Filme] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    class func identifier() -> String {
        return String(describing: self)
    }
    
    private func setup() {
        buildViewHiererchy()
        addConstraints()
    }
    
    private func buildViewHiererchy() {
        contentView.addSubview(collectionView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    public func updateView(_ filmes: [Filme]) {
        self.filmes = filmes
        self.collectionView.reloadData()
    }
}

extension CategoriaTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filmes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FIlmeCollectionViewCell.identifier(), for: indexPath) as! FIlmeCollectionViewCell
        cell.updateFilme(filmes[indexPath.row])
        return cell
    }
}

extension CategoriaTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 130)
    }
}
