//
//  AccountController.swift
//  NewsToDay
//
//  Created by sidzhe on 08.05.2023.
//

import UIKit
import SnapKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import FirebaseFirestore

final class AccountController: UIViewController {
    
    //MARK: UI Elements
    
    private let db = Firestore.firestore()
    
    private lazy var header: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.interSemiBold.rawValue, size: 24)
        label.text = Constants.String.welcome
        return label
    }()
    
    private lazy var underHeader: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.interRegular.rawValue, size: 16)
        label.text = Constants.String.iAm
        label.numberOfLines = 2
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var emailTextField: UITextField = {
        let text = UITextField()
        text.placeholder = Constants.String.email
        text.font = UIFont(name: Font.interMedium.rawValue, size: 16)
        text.autocapitalizationType = .none
        text.autocorrectionType = .no
        text.delegate = self
        return text
    }()
    
    private lazy var passwordTextField: UITextField = {
        let text = UITextField()
        text.placeholder = Constants.String.password
        text.font = UIFont(name: Font.interMedium.rawValue, size: 16)
        text.autocapitalizationType = .none
        text.autocorrectionType = .no
        text.isSecureTextEntry = true 
        text.textContentType = .oneTimeCode
        text.delegate = self
        return text
    }()
    
    private lazy var emailView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.borderColor = UIColor(named: Colors.purplePrimary.rawValue)?.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private lazy var passwordView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.borderColor = UIColor(named: Colors.purplePrimary.rawValue)?.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private lazy var signButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.String.signIn, for: .normal)
        button.backgroundColor = UIColor(named: Colors.purplePrimary.rawValue)
        button.layer.cornerRadius = 15
        button.titleLabel?.font = UIFont(name: Font.interSemiBold.rawValue, size: 16)
        button.addTarget(self, action: #selector(tapButton(sender:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var googleSingIn: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.String.google, for: .normal)
        button.backgroundColor = UIColor(named: Colors.purplePrimary.rawValue)
        button.layer.cornerRadius = 15
        button.titleLabel?.font = UIFont(name: Font.interSemiBold.rawValue, size: 16)
        button.addTarget(self, action: #selector(googleSign), for: .touchUpInside)
        return button
    }()
    
    private lazy var registrButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.String.dontAc, for: .normal)
        button.titleLabel?.font = UIFont(name: Font.interMedium.rawValue, size: 16)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(tapButton(sender:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var hideButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: Constants.Images.eye), for: .normal)
        button.tintColor = UIColor(named: Colors.purplePrimary.rawValue)
        button.addTarget(self, action: #selector(hidePressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var emailImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: Constants.Images.envelope)
        image.tintColor = UIColor(named: Colors.purplePrimary.rawValue)
        return image
    }()
    
    private lazy var passwordImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: Constants.Images.lock)
        image.tintColor = UIColor(named: Colors.purplePrimary.rawValue)
        return image
    }()
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        return tapGesture
    }()
    
    //MARK: Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
    }
    
    //MARK: Setup Views
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addGestureRecognizer(tapGesture)
        
        view.addSubview(header)
        view.addSubview(underHeader)
        view.addSubview(emailView)
        view.addSubview(passwordView)
        view.addSubview(signButton)
        view.addSubview(registrButton)
        view.addSubview(googleSingIn)
        
        emailView.addSubview(emailTextField)
        emailView.addSubview(emailImage)
        
        passwordView.addSubview(passwordTextField)
        passwordView.addSubview(passwordImage)
        passwordView.addSubview(hideButton)
        
        header.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.left.equalToSuperview().inset(20)
        }
        
        underHeader.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom).offset(8)
            make.left.equalToSuperview().inset(20)
        }
        
        emailView.snp.makeConstraints { make in
            make.top.equalTo(underHeader.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(56)
        }
        
        emailImage.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(20)
            make.left.equalToSuperview().inset(18)
            make.centerY.equalToSuperview()
        }
        
        emailTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(emailImage.snp.right).offset(26)
            make.right.equalToSuperview().inset(20)
        }
        
        passwordView.snp.makeConstraints { make in
            make.top.equalTo(emailView.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(56)
        }
        
        passwordImage.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(20)
            make.left.equalToSuperview().inset(18)
            make.centerY.equalToSuperview()
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(emailImage.snp.right).offset(26)
            make.right.equalTo(hideButton.snp.left)
        }
        
        signButton.snp.makeConstraints { make in
            make.top.equalTo(passwordView.snp.bottom).offset(64)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(56)
        }
        
        registrButton.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalTo(250)
            make.bottom.equalToSuperview().inset(42)
            make.centerX.equalToSuperview()
        }
        
        hideButton.snp.makeConstraints { make in
            make.size.equalTo(25)
            make.right.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        googleSingIn.snp.makeConstraints { make in
            make.bottom.equalTo(registrButton.snp.top).offset(-64)
            make.horizontalEdges.equalToSuperview().inset(80)
            make.height.equalTo(56)
        }
    }
    
    //MARK: Google sign in method
    
    @objc private func googleSign() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { result, error in
            guard error == nil else { return }
            guard let user = result?.user, let idToken = user.idToken?.tokenString else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            Auth.auth().signIn(with: credential) { result, error in
                self.navigationController?.pushViewController(RegisterController(), animated: true)
                self.currentData()
            }
        }
    }
    
    //MARK: objc methods
    
    @objc private func hidePressed() {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    @objc private func tapButton(sender: UIButton) {
        if sender.currentTitle == Constants.String.signIn {
            guard let email = emailTextField.text else { return }
            guard let password = passwordTextField.text else { return }
            
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    let alertController = UIAlertController(title: Constants.String.info,
                                                            message: error.localizedDescription,
                                                            preferredStyle: .alert)
                    let action = UIAlertAction(title: Constants.String.ok, style: .cancel, handler: nil)
                    alertController.addAction(action)
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    let coordinator = Builder()
                    let tabbar = TabBarController(coordinator: coordinator)
                    self.navigationController?.pushViewController(tabbar, animated: true)
                }
            }
        } else {
            navigationController?.pushViewController(RegisterController(), animated: true)
        }
    }
    
    func currentData() {
        guard let email = Auth.auth().currentUser?.email else { return }
        let location = Web.Region.unitedStates
        let categoies = [String]()
        db.collection(email).addDocument(data: ["location" : location, "categories" : categoies])
    }
}

//MARK: Extension UITextFieldDelegate

extension AccountController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
