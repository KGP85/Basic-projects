//
//  HTTPMethod.swift
//  PizzaDeliveryApp
//
//  Created by Даниил Муратович on 04.07.2025.
//


import Foundation

enum HTTPMethod: String {
    case GET, POST
}

final class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://mock-api-for-pizza-delivery.com/"
    
    func request<T: Decodable>(endpoint: String, method: HTTPMethod) async throws -> T {
        guard let url = URL(string: baseURL + endpoint) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
