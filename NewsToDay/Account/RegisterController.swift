//
//  RegisterController.swift
//  NewsToDay
//
//  Created by sidzhe on 08.05.2023.
//

import UIKit
import SnapKit
import FirebaseAuth

class RegisterController: UIViewController {
    
    //MARK: UI Elements
    
    private lazy var header: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.text = Constants.String.welcomeToNews
        return label
    }()
    
    private lazy var underHeader: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.text = Constants.String.hello
        label.numberOfLines = 2
        label.textColor = .systemGray2
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let text = UITextField()
        text.placeholder = Constants.String.name
        text.delegate = self
        return text
    }()
    
    private lazy var emailTextField: UITextField = {
        let text = UITextField()
        text.placeholder = Constants.String.email
        text.delegate = self
        return text
    }()
    
    private lazy var passwordFirstTextField: UITextField = {
        let text = UITextField()
        text.placeholder = Constants.String.password
        text.isSecureTextEntry = true
        text.delegate = self
        return text
    }()
    
    private lazy var passwordSecondTextField: UITextField = {
        let text = UITextField()
        text.placeholder = Constants.String.repeatPas
        text.isSecureTextEntry = true
        text.delegate = self
        return text
    }()
    
    private lazy var nameView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.borderColor = UIColor.blue.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private lazy var emailView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.borderColor = UIColor.blue.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private lazy var passwordFirstView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.borderColor = UIColor.blue.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private lazy var passwordSecondView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.borderColor = UIColor.blue.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    
    private lazy var signButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.String.signUp, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var registrButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.String.haveAnAcc, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(backToSign), for: .touchUpInside)
        return button
    }()
    
    private lazy var nameImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: Constants.Images.person)
        image.tintColor = .gray
        return image
    }()
    
    private lazy var emailImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: Constants.Images.envelope)
        image.tintColor = .gray
        return image
    }()
    
    private lazy var passwordImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: Constants.Images.lock)
        image.tintColor = .gray
        return image
    }()
    
    private lazy var passwordImageTwo: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: Constants.Images.lock)
        image.tintColor = .gray
        return image
    }()
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        return tapGesture
    }()
    
    private lazy var hideButtonOne: UIButton = {
        let button = UIButton(type: .custom)
        button.tag = Constants.String.eight
        button.setImage(UIImage(systemName: Constants.Images.eye), for: .normal)
        button.addTarget(self, action: #selector(hidePressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var hideButtonTwo: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: Constants.Images.eye), for: .normal)
        button.addTarget(self, action: #selector(hidePressed(sender:)), for: .touchUpInside)
        return button
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
        view.addSubview(nameView)
        view.addSubview(emailView)
        view.addSubview(passwordFirstView)
        view.addSubview(passwordSecondView)
        view.addSubview(signButton)
        view.addSubview(registrButton)
        
        nameView.addSubview(nameImage)
        nameView.addSubview(nameTextField)
        emailView.addSubview(emailImage)
        emailView.addSubview(emailTextField)
        passwordFirstView.addSubview(passwordImage)
        passwordFirstView.addSubview(passwordFirstTextField)
        passwordFirstView.addSubview(hideButtonOne)
        passwordSecondView.addSubview(passwordImageTwo)
        passwordSecondView.addSubview(passwordSecondTextField)
        passwordSecondView.addSubview(hideButtonTwo)
        
        header.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.left.equalToSuperview().inset(20)
        }
        
        underHeader.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom).offset(8)
            make.left.equalToSuperview().inset(20)
        }
        
        nameView.snp.makeConstraints { make in
            make.top.equalTo(underHeader.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(56)
        }
        
        nameImage.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(20)
            make.left.equalToSuperview().inset(18)
            make.centerY.equalToSuperview()
        }
        
        nameTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(nameImage.snp.right).offset(26)
        }
        
        emailView.snp.makeConstraints { make in
            make.top.equalTo(nameView.snp.bottom).offset(32)
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
            make.left.equalTo(nameImage.snp.right).offset(26)
        }
        
        passwordFirstView.snp.makeConstraints { make in
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
        
        passwordFirstTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(nameImage.snp.right).offset(26)
        }
        
        passwordSecondView.snp.makeConstraints { make in
            make.top.equalTo(passwordFirstView.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(56)
        }
        
        passwordImageTwo.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(20)
            make.left.equalToSuperview().inset(18)
            make.centerY.equalToSuperview()
        }
        
        passwordSecondTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(nameImage.snp.right).offset(26)
        }
        
        signButton.snp.makeConstraints { make in
            make.top.equalTo(passwordSecondView.snp.bottom).offset(64)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(56)
        }
        
        registrButton.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalTo(250)
            make.bottom.equalToSuperview().inset(42)
            make.centerX.equalToSuperview()
        }
        
        hideButtonOne.snp.makeConstraints { make in
            make.size.equalTo(25)
            make.right.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        hideButtonTwo.snp.makeConstraints { make in
            make.size.equalTo(25)
            make.right.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
    }
    
    //MARK: Objec methods
    
    @objc private func hidePressed(sender: UIButton) {
        if sender.tag == Constants.String.eight {
            passwordFirstTextField.isSecureTextEntry = !passwordFirstTextField.isSecureTextEntry
        } else {
            passwordSecondTextField.isSecureTextEntry = !passwordSecondTextField.isSecureTextEntry
        }
    }
        
        @objc private func backToSign() {
            dismiss(animated: true)
        }
        
        @objc private func tapButton() {
            if passwordFirstTextField.text != passwordSecondTextField.text {
                let alertController = UIAlertController(title: Constants.String.info,
                                                        message: Constants.String.errorPassword,
                                                        preferredStyle: .alert)
                let action = UIAlertAction(title: Constants.String.ok, style: .cancel, handler: nil)
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)
            }
            guard let email = emailTextField.text else { return }
            guard let password = passwordFirstTextField.text else { return }
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    let alertController = UIAlertController(title: Constants.String.info,
                                                            message: error.localizedDescription,
                                                            preferredStyle: .alert)
                    let action = UIAlertAction(title: Constants.String.ok, style: .cancel, handler: nil)
                    alertController.addAction(action)
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    //                navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
                    print("ok")
                }
            }
        }
    }
    
    //MARK: Extension UITextFieldDelegate
    
    extension RegisterController: UITextFieldDelegate {
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
    }
