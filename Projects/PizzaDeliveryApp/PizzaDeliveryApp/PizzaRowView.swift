//
//  PizzaRowView.swift
//  PizzaDeliveryApp
//
//  Created by Даниил Муратович on 04.07.2025.
//


import SwiftUI

struct PizzaRowView: View {
    let pizza: Pizza
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: pizza.imageName)) { image in
                image.resizable()
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .foregroundColor(.gray)
            }
            .frame(width: 80, height: 80)
            .cornerRadius(10)
            
            VStack(alignment: .leading) {
                Text(pizza.name)
                    .font(.headline)
                Text(pizza.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("\(Int(pizza.basePrice)) ₽")
                    .font(.subheadline)
                    .bold()
            }
            .padding(.leading, 8)
        }
        .padding(.vertical, 8)
    }
}
