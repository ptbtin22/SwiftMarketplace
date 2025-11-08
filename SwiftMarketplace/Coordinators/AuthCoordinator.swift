//
//  AuthCoordinator.swift
//  SwiftMarketplace
//
//  Created by Tin Pham on 8/11/25.
//

import UIKit

protocol AuthCoordinatorDelegate: AnyObject {
    func authCoordinatorDidFinish(_ coordinator: AuthCoordinator)
}

final class AuthCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    weak var delegate: AuthCoordinatorDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginVC = LoginViewController()
        loginVC.coordinator = self
        
        navigationController.pushViewController(loginVC, animated: true)
    }
    
    // MARK: - Navigation Actions
    
    func didFinishLogin() {
        delegate?.authCoordinatorDidFinish(self)
    }
}
