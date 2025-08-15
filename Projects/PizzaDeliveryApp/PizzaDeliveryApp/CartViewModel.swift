//
//  CartViewModel.swift
//  PizzaDeliveryApp
//
//  Created by Даниил Муратович on 04.07.2025.
//


import Foundation

final class CartViewModel: ObservableObject {
    @Published var items: [CartItem] = []
    
    var totalAmount: Double {
        items.reduce(0) { $0 + $1.totalPrice }
    }
    
    func addItem(_ pizza: Pizza, size: PizzaSize) {
        if let index = items.firstIndex(where: { $0.pizza.id == pizza.id && $0.size == size }) {
            items[index].quantity += 1
        } else {
            items.append(CartItem(pizza: pizza, size: size, quantity: 1))
        }
    }
    
    func removeItem(at indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
}
