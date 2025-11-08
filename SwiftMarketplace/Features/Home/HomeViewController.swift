//
//  HomeViewController.swift
//  SwiftMarketplace
//
//  Created by Tin Pham on 7/11/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    weak var coordinator: HomeCoordinator?
    
    // MARK: - UI Components
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to SwiftMarketplace! 🎉"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "You have successfully logged in!"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark.circle.fill")
        imageView.tintColor = .systemGreen
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(checkmarkImageView)
        view.addSubview(welcomeLabel)
        view.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            checkmarkImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkmarkImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: 100),
            checkmarkImageView.heightAnchor.constraint(equalToConstant: 100),
            
            welcomeLabel.topAnchor.constraint(equalTo: checkmarkImageView.bottomAnchor, constant: 32),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            subtitleLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 12),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
        
        // Add animation
        animateCheckmark()
    }
    
    private func animateCheckmark() {
        checkmarkImageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        checkmarkImageView.alpha = 0
        
        UIView.animate(withDuration: 0.6, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5) {
            self.checkmarkImageView.transform = .identity
            self.checkmarkImageView.alpha = 1
        }
    }

}

#if DEBUG

@available(iOS 17.0, *) // Previews require iOS 17+ to run
#Preview("Home Screen") {
    let vc = HomeViewController()
    
    // Pro-tip: To see the navigation bar, embed it in a UINavigationController
    UINavigationController(rootViewController: vc)
}

#endif
