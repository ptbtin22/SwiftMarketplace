//
//  HomeViewController.swift
//  SwiftMarketplace
//
//  Created by Tin Pham on 7/11/25.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemPink
    }

}

#if DEBUG

@available(iOS 17.0, *) // Previews require iOS 17+ to run
#Preview("Home Screen") {
    // You can just instantiate your controller
    let vc = HomeViewController()
    
    // Pro-tip: To see the navigation bar, embed it in a UINavigationController
    return UINavigationController(rootViewController: vc)
}

#endif
