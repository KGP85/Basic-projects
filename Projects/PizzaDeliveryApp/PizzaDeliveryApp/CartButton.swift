//
//  CartButton.swift
//  PizzaDeliveryApp
//
//  Created by Даниил Муратович on 04.07.2025.
//


import SwiftUI

struct CartButton: View {
    let count: Int
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(systemName: "cart")
                .font(.title)
                .padding(.top, 5)
            
            if count > 0 {
                Text("\(count)")
                    .font(.caption2)
                    .bold()
                    .foregroundColor(.white)
                    .frame(width: 20, height: 20)
                    .background(Color.red)
                    .clipShape(Circle())
            }
        }
    }
}
