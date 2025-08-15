//
//  CartView.swift
//  PizzaDeliveryApp
//
//  Created by Даниил Муратович on 04.07.2025.
//


import SwiftUI

struct CartView: View {
    @EnvironmentObject private var cart: CartViewModel
    @State private var showingOrderConfirmation = false
    
    var body: some View {
        VStack {
            if cart.items.isEmpty {
                Spacer()
                Text("Корзина пуста")
                    .font(.title)
                    .foregroundColor(.secondary)
                Spacer()
            } else {
                List {
                    ForEach(cart.items) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.pizza.name)
                                    .font(.headline)
                                Text("\(item.size.rawValue) x \(item.quantity)")
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Text("\(Int(item.totalPrice)) ₽")
                        }
                    }
                    .onDelete(perform: cart.removeItem)
                    
                    HStack {
                        Text("Итого:")
                            .font(.title2)
                        Spacer()
                        Text("\(Int(cart.totalAmount)) ₽")
                            .font(.title2)
                            .bold()
                    }
                }
                
                Button(action: {
                    showingOrderConfirmation = true
                }) {
                    Text("Оформить заказ")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(15)
                }
                .padding()
                .sheet(isPresented: $showingOrderConfirmation) {
                    OrderConfirmationView()
                }
            }
        }
        .navigationTitle("Корзина")
    }
}
