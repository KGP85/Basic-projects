//
//  DishCell.swift
//  Dostavka
//
//  Created by Даниил Муратович on 24.07.2025.
//
import UIKit

class DishCell: UITableViewCell {
    private let dishImageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let priceLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, priceLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        
        [dishImageView, stackView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            dishImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            dishImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dishImageView.widthAnchor.constraint(equalToConstant: 80),
            dishImageView.heightAnchor.constraint(equalToConstant: 80),
            dishImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),
            
            stackView.leadingAnchor.constraint(equalTo: dishImageView.trailingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.centerYAnchor.constraint(equalTo: dishImageView.centerYAnchor)
        ])
    }
    
    func configure(with dish: Dish) {
        titleLabel.text = dish.name
        descriptionLabel.text = dish.description
        priceLabel.text = "\(dish.price) ₽"
        // Загрузка изображения из сети или локальных ресурсов
    }
}
