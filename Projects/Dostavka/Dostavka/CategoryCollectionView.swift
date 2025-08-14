//
//  CategoryCollectionView.swift
//  Dostavka
//
//  Created by Даниил Муратович on 24.07.2025.
//
import UIKit

class CategoryCollectionView: UICollectionView {
    private let categories: [Category]
    
    init(categories: [Category]) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        setupCollection()
    }
    
    private func setupCollection() {
        register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        delegate = self
        dataSource = self
    }
}

extension CategoryCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        cell.configure(with: categories[indexPath.item])
        return cell
    }
}

extension CategoryCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: .scrollToSection, object: indexPath.item)
    }
}
