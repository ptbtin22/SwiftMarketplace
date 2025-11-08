//
//  LoginViewModel.swift
//  SwiftMarketplace
//
//  Created by Tin Pham on 8/11/25.
//

import Foundation
import Combine

class LoginViewModel {
    
    // MARK: - Published Properties (Output)
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var isLoginButtonEnabled: Bool = false
    
    // MARK: - Subjects (Events)
    
    let loginSuccessSubject = PassthroughSubject<Void, Never>()
    
    // MARK: - Private Properties
    
    private var cancallables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init() {
        setupBindings()
    }
    
    private func setupBindings() {
        Publishers.CombineLatest($email, $password)
            .map { email, password in
                return self.isValidEmail(email) && self.isValidPassword(password)
            }
            .assign(to: &$isLoginButtonEnabled)
    }
}

// MARK: - Validation

extension LoginViewModel {
    private func isValidEmail(_ email: String) -> Bool {
        return !email.isEmpty && email.contains("@")
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        return password.count >= 6
    }
}
