//
//  NetworkService.swift
//  Dostavka
//
//  Created by Даниил Муратович on 24.07.2025.
//
import Foundation

class NetworkService {
    func fetchCategories(completion: @escaping (Result<[Category], Error>) -> Void) {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/categories.php") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0)))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(CategoriesResponse.self, from: data)
                completion(.success(response.categories))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

struct CategoriesResponse: Codable {
    let categories: [Category]
}

struct Category: Codable {
    let idCategory: String
    let strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
}
