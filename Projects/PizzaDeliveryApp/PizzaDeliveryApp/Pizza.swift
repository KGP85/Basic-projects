//
//  Pizza.swift
//  PizzaDeliveryApp
//
//  Created by Даниил Муратович on 04.07.2025.
//


import Foundation

struct Pizza: Identifiable, Decodable {
    let id: Int
    let name: String
    let description: String
    let basePrice: Double
    let imageName: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, description
        case basePrice = "price"
        case imageName = "image"
    }
}
enum PizzaSize: String, CaseIterable {
    case small = "Маленькая"
    case medium = "Средняя"
    case large = "Большая"
    
    var priceMultiplier: Double {
        switch self {
        case .small: return 0.8
        case .medium: return 1.0
        case .large: return 1.4
        }
    }
}
struct CartItem: Identifiable {
    let id = UUID()
    let pizza: Pizza
    var size: PizzaSize
    var quantity: Int
    
    var totalPrice: Double {
        pizza.basePrice * size.priceMultiplier * Double(quantity)
    }
}
