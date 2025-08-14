//
//  CacheService.swift
//  Dostavka
//
//  Created by Даниил Муратович on 24.07.2025.
//
import Foundation
import UIKit

class CacheService {
    static let shared = CacheService()
    private let userDefaults = UserDefaults.standard
    private let categoriesKey = "cachedCategories"
    
    func saveCategories(_ categories: [Category]) {
        if let data = try? JSONEncoder().encode(categories) {
            userDefaults.set(data, forKey: categoriesKey)
        }
    }
    
    func loadCategories() -> [Category]? {
        guard let data = userDefaults.data(forKey: categoriesKey) else { return nil }
        return try? JSONDecoder().decode([Category].self, from: data)
    }
}
