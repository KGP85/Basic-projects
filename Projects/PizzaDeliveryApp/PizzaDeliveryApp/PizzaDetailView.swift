//
//  PizzaDetailView.swift
//  PizzaDeliveryApp
//
//  Created by Даниил Муратович on 04.07.2025.
//


import SwiftUI

struct PizzaDetailView: View {
    @EnvironmentObject private var cart: CartViewModel
    let pizza: Pizza
    @State private var selectedSize: PizzaSize = .medium
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: pizza.imageName)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
            }
            .frame(height: 200)
            .cornerRadius(20)
            .padding()
            
            Text(pizza.name)
                .font(.title)
            
            Text(pizza.description)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Picker("Размер", selection: $selectedSize) {
                ForEach(PizzaSize.allCases, id: \.self) { size in
                    Text(size.rawValue).tag(size)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            Text("Цена: \(Int(calculatePrice())) ₽")
                .font(.title2)
                .bold()
                .padding()
            
            Button(action: {
                cart.addItem(pizza, size: selectedSize)
            }) {
                Text("Добавить в корзину")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .cornerRadius(10)
            }
            .padding()
            
            Spacer()
        }
        .navigationTitle("Выбор пиццы")
    }
    
    private func calculatePrice() -> Double {
        pizza.basePrice * selectedSize.priceMultiplier
    }
}
