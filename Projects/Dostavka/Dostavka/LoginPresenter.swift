//
//  LoginPresenter.swift
//  Dostavka
//
//  Created by Даниил Муратович on 24.07.2025.
//
import Foundation
import UIKit

class LoginPresenter: LoginPresenterProtocol {
    weak var view: LoginViewProtocol?
    private let router: LoginRouterProtocol
    
    init(view: LoginViewProtocol, router: LoginRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func login(email: String?, password: String?) {
        guard let email = email, !email.isEmpty,
              let password = password, !password.isEmpty else {
            view?.showError("All fields are required")
            return
        }
        router.navigateToHome()
    }
}
