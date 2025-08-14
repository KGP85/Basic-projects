//
//  HomePresenter.swift
//  Dostavka
//
//  Created by Даниил Муратович on 24.07.2025.
//
import Foundation
import UIKit

class HomePresenter: HomePresenterProtocol {
    weak var view: HomeViewProtocol?
    private let networkService = NetworkService()
    private let cacheService = CacheService()
    
    init(view: HomeViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        if Reachability.isConnectedToNetwork() {
            fetchCategories()
        } else {
            loadCachedData()
        }
    }
    
    private func fetchCategories() {
        networkService.fetchCategories { [weak self] result in
            switch result {
            case .success(let categories):
                self?.cacheService.saveCategories(categories)
                self?.view?.updateUI(with: categories)
            case .failure:
                self?.loadCachedData()
            }
        }
    }
    
    private func loadCachedData() {
        if let categories = cacheService.loadCategories() {
            view?.updateUI(with: categories)
        } else {
            view?.showError("No internet connection and no cached data")
        }
    }
    
    func didSelectCategory(at index: Int) {
        let indexPath = IndexPath(row: 0, section: index + 2) // +2 для баннеров и заголовка
        (view as? HomeViewController)?.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}
