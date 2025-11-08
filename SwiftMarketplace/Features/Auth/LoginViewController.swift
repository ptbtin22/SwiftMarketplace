//
//  LoginViewController.swift
//  SwiftMarketplace
//
//  Created by Tin Pham on 7/11/25.
//

import UIKit

class LoginViewController: UIViewController {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var coordinator: AuthCoordinator?
    private var loginViewModel: LoginViewModel
    
    init(loginViewModel: LoginViewModel) {
        self.loginViewModel = loginViewModel
    }
    
    // MARK: - UI Components
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.keyboardDismissMode = .interactive
        return scroll
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemBlue
        imageView.image = UIImage(systemName: "cart.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "SwiftMarketplace"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome back! Please login to continue."
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .none
        textField.backgroundColor = .secondarySystemBackground
        textField.font = .systemFont(ofSize: 16)
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.keyboardType = .emailAddress
        textField.textContentType = .emailAddress
        textField.layer.cornerRadius = 12
        
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftViewMode = .always
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.rightViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .none
        textField.backgroundColor = .secondarySystemBackground
        textField.font = .systemFont(ofSize: 16)
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.textContentType = .password
        textField.layer.cornerRadius = 12
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let showPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        button.tintColor = .secondaryLabel
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Forgot Password?", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.filled()
        config.title = "Login"
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        config.cornerStyle = .large
        config.buttonSize = .large
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .systemFont(ofSize: 18, weight: .semibold)
            return outgoing
        }
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let orDividerStack: UIStackView = {
        let leftLine = UIView()
        leftLine.backgroundColor = .separator
        leftLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        let label = UILabel()
        label.text = "OR"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .secondaryLabel
        
        let rightLine = UIView()
        rightLine.backgroundColor = .separator
        rightLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        let stack = UIStackView(arrangedSubviews: [leftLine, label, rightLine])
        stack.axis = .horizontal
        stack.spacing = 16
        stack.alignment = .center
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        leftLine.widthAnchor.constraint(equalTo: rightLine.widthAnchor).isActive = true
        
        return stack
    }()
    
    private let googleSignInButton: UIButton = {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.bordered()
        
        // Create attributed title with Google icon
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "g.circle.fill")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
        let imageString = NSAttributedString(attachment: imageAttachment)
        
        let titleString = NSAttributedString(
            string: "  Continue with Google",
            attributes: [
                .font: UIFont.systemFont(ofSize: 16, weight: .medium),
                .foregroundColor: UIColor.label
            ]
        )
        
        let fullString = NSMutableAttributedString()
        fullString.append(imageString)
        fullString.append(titleString)
        
        config.attributedTitle = AttributedString(fullString)
        config.cornerStyle = .large
        config.buttonSize = .large
        config.baseBackgroundColor = .secondarySystemBackground
        config.baseForegroundColor = .label
        
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        
        let normalText = "Don't have an account? "
        let boldText = "Sign Up"
        
        let attributedString = NSMutableAttributedString(
            string: normalText,
            attributes: [
                .font: UIFont.systemFont(ofSize: 15),
                .foregroundColor: UIColor.secondaryLabel
            ]
        )
        attributedString.append(NSAttributedString(
            string: boldText,
            attributes: [
                .font: UIFont.systemFont(ofSize: 15, weight: .semibold),
                .foregroundColor: UIColor.systemBlue
            ]
        ))
        
        button.setAttributedTitle(attributedString, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
        setupKeyboardObservers()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(logoImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(emailTextField)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(showPasswordButton)
        contentView.addSubview(forgotPasswordButton)
        contentView.addSubview(loginButton)
        contentView.addSubview(orDividerStack)
        contentView.addSubview(googleSignInButton)
        contentView.addSubview(signUpButton)
        
        NSLayoutConstraint.activate([
            // ScrollView
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // ContentView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Logo
            logoImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 60),
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 80),
            logoImageView.heightAnchor.constraint(equalToConstant: 80),
            
            // Title
            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            // Subtitle
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            // Email TextField
            emailTextField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 48),
            emailTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            emailTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            emailTextField.heightAnchor.constraint(equalToConstant: 56),
            
            // Password TextField
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            passwordTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            passwordTextField.heightAnchor.constraint(equalToConstant: 56),
            
            // Show Password Button
            showPasswordButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            showPasswordButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -12),
            showPasswordButton.widthAnchor.constraint(equalToConstant: 44),
            showPasswordButton.heightAnchor.constraint(equalToConstant: 44),
            
            // Forgot Password Button
            forgotPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 12),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            // Login Button
            loginButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 32),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            loginButton.heightAnchor.constraint(equalToConstant: 56),
            
            // OR Divider
            orDividerStack.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 32),
            orDividerStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            orDividerStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            // Google Sign In Button
            googleSignInButton.topAnchor.constraint(equalTo: orDividerStack.bottomAnchor, constant: 24),
            googleSignInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            googleSignInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            googleSignInButton.heightAnchor.constraint(equalToConstant: 56),
            
            // Sign Up Button
            signUpButton.topAnchor.constraint(equalTo: googleSignInButton.bottomAnchor, constant: 32),
            signUpButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            signUpButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32)
        ])
    }
    
    private func setupActions() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        showPasswordButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
        googleSignInButton.addTarget(self, action: #selector(googleSignInTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        
        // Dismiss keyboard on tap
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    // MARK: - Actions
    
    @objc private func loginButtonTapped() {
        dismissKeyboard()
        
        // Validate input
        guard let email = emailTextField.text, !email.isEmpty else {
            showAlert(message: "Please enter your email")
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Please enter your password")
            return
        }
        
        // Simulate login with animation
        loginButton.configuration?.showsActivityIndicator = true
        loginButton.isEnabled = false
        
        // Simulate network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.loginButton.configuration?.showsActivityIndicator = false
            self?.loginButton.isEnabled = true
            
            // Notify coordinator
            self?.coordinator?.didFinishLogin()
        }
    }
    
    @objc private func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()
        let imageName = passwordTextField.isSecureTextEntry ? "eye.slash.fill" : "eye.fill"
        showPasswordButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    @objc private func forgotPasswordTapped() {
        showAlert(message: "Forgot password functionality coming soon!")
    }
    
    @objc private func googleSignInTapped() {
        dismissKeyboard()
        
        // Simulate Google sign-in with animation
        googleSignInButton.configuration?.showsActivityIndicator = true
        googleSignInButton.isEnabled = false
        
        // Simulate OAuth flow delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.googleSignInButton.configuration?.showsActivityIndicator = false
            self?.googleSignInButton.isEnabled = true
            
            // Notify coordinator (Google sign-in successful)
            self?.coordinator?.didFinishLogin()
        }
    }
    
    @objc private func signUpTapped() {
        showAlert(message: "Sign up functionality coming soon!")
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
    
    // MARK: - Helper
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
}

#if DEBUG

@available(iOS 17.0, *) // Previews require iOS 17+ to run
#Preview("Login Screen") {
    let vc = LoginViewController()
    
    // Pro-tip: To see the navigation bar, embed it in a UINavigationController
    UINavigationController(rootViewController: vc)
}

#endif

