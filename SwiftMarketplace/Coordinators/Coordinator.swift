//
//  Coordinator.swift
//  SwiftMarketplace
//
//  Created by Tin Pham on 7/11/25.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    
    func start()
    func addChild(_ child: Coordinator)
    func removeChild(_ child: Coordinator)
}

extension Coordinator {
    func addChild(_ child: Coordinator) {
        childCoordinators.append(child)
    }
    
    func removeChild(_ child: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== child }
    }
}
