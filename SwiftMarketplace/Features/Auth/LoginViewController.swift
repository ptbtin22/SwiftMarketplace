//
//  LoginViewController.swift
//  SwiftMarketplace
//
//  Created by Tin Pham on 7/11/25.
//

import UIKit

class LoginViewController: UIViewController {
    
    private var label: UILabel = {
        let label = UILabel()
        label.text = "Login Screen"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var button: UIButton = {
        let button = UIButton(type: .system)
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Click Me"
        configuration.baseBackgroundColor = .systemBlue
        configuration.baseForegroundColor = .white
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(label)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20)
        ])
    }
    
}

#if DEBUG

@available(iOS 17.0, *) // Previews require iOS 17+ to run
#Preview("Login Screen") {
    // You can just instantiate your controller
    let vc = LoginViewController()
    
    // Pro-tip: To see the navigation bar, embed it in a UINavigationController
    return UINavigationController(rootViewController: vc)
}

#endif
