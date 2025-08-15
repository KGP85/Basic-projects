//
//  MenuView.swift
//  PizzaDeliveryApp
//
//  Created by Даниил Муратович on 04.07.2025.
//


import SwiftUI

struct MenuView: View {
    @StateObject private var viewModel = MenuViewModel()
    @EnvironmentObject private var cart: CartViewModel
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Загрузка меню...")
                } else if viewModel.pizzas.isEmpty {
                    Text("Нет доступных пицц")
                        .foregroundColor(.secondary)
                } else {
                    List(viewModel.pizzas) { pizza in
                        NavigationLink(destination: PizzaDetailView(pizza: pizza)) {
                            PizzaRowView(pizza: pizza)
                        }
                    }
                }
            }
            .navigationTitle("Меню")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: CartView()) {
                        CartButton(count: cart.items.reduce(0) { $0 + $1.quantity })
                    }
                }
            }
            .task {
                await viewModel.loadPizzas()
            }
        }
    }
}
