//
//  OrderConfirmationView.swift
//  PizzaDeliveryApp
//
//  Created by Даниил Муратович on 04.07.2025.
//


import SwiftUI

struct OrderConfirmationView: View {
    @EnvironmentObject private var cart: CartViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.green)
            
            Text("Заказ оформлен!")
                .font(.largeTitle)
                .bold()
            
            Text("Ваш заказ на сумму \(Int(cart.totalAmount)) ₽ принят в обработку")
                .multilineTextAlignment(.center)
                .padding()
            
            Button("Отлично!") {
                cart.items.removeAll()
                dismiss()
            }
            .font(.title2)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding()
        }
        .padding()
    }
}
