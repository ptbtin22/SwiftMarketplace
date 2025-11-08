//
//  AppCoordinator.swift
//  SwiftMarketplace
//
//  Created by Tin Pham on 7/11/25.
//

import UIKit
import FirebaseCore
import FirebaseAuth


class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        
        self.navigationController.navigationBar.isHidden = true
    }
    
    // MARK: - Start
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        // TODO: Replace with actual auth check (e.g., check UserDefaults, Keychain, etc.)
        let isAuthenticated = false
        
        if isAuthenticated {
            runMainFlow()
        } else {
            runAuthFlow()
        }
    }
    
    // MARK: - Flows
    
    // auth flow
    private func runAuthFlow() {
        let authCoordinator = AuthCoordinator(navigationController: navigationController)
        
        authCoordinator.delegate = self
        
        addChild(authCoordinator)
        
        authCoordinator.start()
    }
    
    // main flow
    private func runMainFlow() {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        
        homeCoordinator.delegate = self
        
        addChild(homeCoordinator)
        
        homeCoordinator.start()
    }
}

// MARK: - AuthCoordinatorDelegate

extension AppCoordinator: AuthCoordinatorDelegate {
    func authCoordinatorDidFinish(_ coordinator: AuthCoordinator) {
        // Remove auth coordinator
        removeChild(coordinator)
        
        // TODO: Save authentication state (e.g., UserDefaults, Keychain)
        
        // Start main flow
        runMainFlow()
    }
}

// MARK: - HomeCoordinatorDelegate

extension AppCoordinator: HomeCoordinatorDelegate {
    func homeCoordinatorDidFinish(_ coordinator: HomeCoordinator) {
        // Remove home coordinator
        removeChild(coordinator)
        
        // TODO: Clear authentication state
        
        // Return to auth flow
        runAuthFlow()
    }
}
