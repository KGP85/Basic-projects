//
//  CategoryCell.swift
//  Dostavka
//
//  Created by Даниил Муратович on 24.07.2025.
//
import UIKit

class CategoryCell: UICollectionViewCell {
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 14)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }
    
    func configure(with category: Category) {
        titleLabel.text = category.strCategory
    }
}
