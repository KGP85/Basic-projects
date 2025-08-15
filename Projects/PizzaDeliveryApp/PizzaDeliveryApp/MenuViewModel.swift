//
//  MenuViewModel.swift
//  PizzaDeliveryApp
//
//  Created by Даниил Муратович on 04.07.2025.
//


import Foundation

final class MenuViewModel: ObservableObject {
    @Published var pizzas: [Pizza] = []
    @Published var isLoading = false
    
    func loadPizzas() async {
        isLoading = true
        
        pizzas = [
            Pizza(id: 1, 
                  name: "Маргарита", 
                  description: "Томатный соус, моцарелла, базилик", 
                  basePrice: 399,
                  imageName: "https://example.com/margherita.jpg"),
            
            Pizza(id: 2, 
                  name: "Пепперони",
                  description: "Пепперони, моцарелла, томатный соус",
                  basePrice: 449,
                  imageName: "https://example.com/pepperoni.jpg"),
            
            Pizza(id: 3, 
                  name: "Гавайская",
                  description: "Ветчина, ананас, моцарелла",
                  basePrice: 479,
                  imageName: "https://example.com/hawaiian.jpg")
        ]
        isLoading = false
    }
}
