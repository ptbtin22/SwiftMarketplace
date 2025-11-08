//
//  HomeCoordinator.swift
//  SwiftMarketplace
//
//  Created by Tin Pham on 8/11/25.
//

import UIKit

protocol HomeCoordinatorDelegate: AnyObject {
    func homeCoordinatorDidFinish(_ coordinator: HomeCoordinator)
}

final class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    weak var delegate: HomeCoordinatorDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeVC = HomeViewController()
        homeVC.coordinator = self
        
        navigationController.setViewControllers([homeVC], animated: true)
    }
    
    // MARK: - Navigation Actions
    
    func didFinish() {
        delegate?.homeCoordinatorDidFinish(self)
    }
}
