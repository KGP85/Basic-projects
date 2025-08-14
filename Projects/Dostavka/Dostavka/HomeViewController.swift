//
//  HomeViewController.swift
//  Dostavka
//
//  Created by Даниил Муратович on 24.07.2025.
//
import UIKit
import Foundation

class HomeViewController: UIViewController, HomeViewProtocol {
    private let tableView = UITableView()
    private let stickyHeaderView = UIView()
    private let categoryCollectionView: UICollectionView
    private var categories: [Category] = []
    private var dishes: [String: [Dish]] = [:]
    
    var presenter: HomePresenterProtocol!
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = HomePresenter(view: self)
        setupUI()
        presenter.viewDidLoad()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // TableView setup
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DishCell.self, forCellReuseIdentifier: "DishCell")
        tableView.register(BannerCell.self, forCellReuseIdentifier: "BannerCell")
        tableView.register(CategoryHeaderView.self, forHeaderFooterViewReuseIdentifier: "CategoryHeader")
        
        // Sticky header setup
        stickyHeaderView.backgroundColor = .white
        stickyHeaderView.addSubview(categoryCollectionView)
        
        // CollectionView setup
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        categoryCollectionView.backgroundColor = .white
        categoryCollectionView.showsHorizontalScrollIndicator = false
        
        [tableView, stickyHeaderView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stickyHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stickyHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stickyHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stickyHeaderView.heightAnchor.constraint(equalToConstant: 50),
            
            categoryCollectionView.topAnchor.constraint(equalTo: stickyHeaderView.topAnchor),
            categoryCollectionView.leadingAnchor.constraint(equalTo: stickyHeaderView.leadingAnchor),
            categoryCollectionView.trailingAnchor.constraint(equalTo: stickyHeaderView.trailingAnchor),
            categoryCollectionView.bottomAnchor.constraint(equalTo: stickyHeaderView.bottomAnchor)
        ])
        
        stickyHeaderView.isHidden = true
    }
    
    func updateUI(with categories: [Category]) {
        self.categories = categories
        tableView.reloadData()
        categoryCollectionView.reloadData()
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let categoryHeaderPosition = tableView.rectForHeader(inSection: 1)
        let position = tableView.convert(categoryHeaderPosition, to: view)
        
        if position.origin.y <= view.safeAreaInsets.top {
            stickyHeaderView.isHidden = false
        } else {
            stickyHeaderView.isHidden = true
        }
    }
}
