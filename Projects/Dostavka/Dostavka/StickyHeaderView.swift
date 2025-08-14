//
//  StickyHeaderView.swift
//  Dostavka
//
//  Created by Даниил Муратович on 24.07.2025.
//
import UIKit

class StickyHeaderView: UIView {
    private let categoryCollectionView: CategoryCollectionView
    
    init(categories: [Category]) {
        categoryCollectionView = CategoryCollectionView(categories: categories)
        super.init(frame: .zero)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(categoryCollectionView)
        // Констрейнты...
    }
}
