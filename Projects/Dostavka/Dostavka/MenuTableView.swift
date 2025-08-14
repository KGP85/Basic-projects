//
//  MenuTableView.swift
//  Dostavka
//
//  Created by Даниил Муратович on 24.07.2025.
//
import UIKit

class MenuTableView: UITableView {
    private var dishes: [Dish] = []
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: .grouped)
        setupTable()
        NotificationCenter.default.addObserver(self, selector: #selector(scrollToSection), name: .scrollToSection, object: nil)
    }
    
    @objc private func scrollToSection(_ notification: Notification) {
        guard let section = notification.object as? Int else { return }
        scrollToRow(at: IndexPath(row: 0, section: section), at: .top, animated: true)
    }
}

// В HomeViewController
func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let offsetY = scrollView.contentOffset.y
    let stickyHeaderY = headerView.frame.minY
    // Логика прилипания заголовка
}
