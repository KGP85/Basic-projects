//
//  LoginRouterProtocol.swift
//  Dostavka
//
//  Created by Даниил Муратович on 24.07.2025.
//
import UIKit

protocol LoginRouterProtocol {
    func navigateToHome()
}

class LoginRouter: LoginRouterProtocol {
    weak var view: UIViewController?
    
    func navigateToHome() {
        let homeVC = HomeViewController()
        homeVC.modalPresentationStyle = .fullScreen
        view?.navigationController?.pushViewController(homeVC, animated: true)
    }
}
