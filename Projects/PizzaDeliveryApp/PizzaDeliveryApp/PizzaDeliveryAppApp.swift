//
//  PizzaDeliveryAppApp.swift
//  PizzaDeliveryApp
//
//  Created by Даниил Муратович on 04.07.2025.
//

import SwiftUI

@main
struct PizzaDeliveryApp: App {
    @StateObject private var cart = CartViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(cart)
        }
    }
}
