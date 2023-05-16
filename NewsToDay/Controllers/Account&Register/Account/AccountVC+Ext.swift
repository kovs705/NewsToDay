//
//  AccountVC+Ext.swift
//  NewsToDay
//
//  Created by Kovs on 13.05.2023.
//

import UIKit
import SnapKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

// MARK: Extension UITextFieldDelegate
extension AccountVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

class AccountVC: UIViewController {
    
    var presenter: AccountPresenter!
    
    // MARK: - UI Properties
    
    lazy var header: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Font.interSemiBold, size: 24)
        label.text = Constants.String.welcome
        return label
    }()
    
    lazy var underHeader: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Font.interRegular, size: 16)
        label.text = Constants.String.iAm
        label.numberOfLines = 2
        label.textColor = .systemGray
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        let text = UITextField()
        text.placeholder = Constants.String.email
        text.font = UIFont(name: Constants.Font.interMedium, size: 16)
        text.delegate = self
        return text
    }()
    
    lazy var passwordTextField: UITextField = {
        let text = UITextField()
        text.placeholder = Constants.String.password
        text.font = UIFont(name: Constants.Font.interMedium, size: 16)
        text.isSecureTextEntry = true
        text.delegate = self
        return text
    }()
    
    lazy var emailView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.borderColor = UIColor(named: Colors.purplePrimary)?.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    lazy var passwordView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.borderColor = UIColor(named: Colors.purplePrimary)?.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    lazy var signButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.String.signIn, for: .normal)
        button.backgroundColor = UIColor(named: Colors.purplePrimary)
        button.layer.cornerRadius = 15
        button.titleLabel?.font = UIFont(name: Constants.Font.interSemiBold, size: 16)
        button.addTarget(self, action: #selector(tapButton(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var googleSingIn: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.String.google, for: .normal)
        button.backgroundColor = UIColor(named: Colors.purplePrimary)
        button.layer.cornerRadius = 15
        button.titleLabel?.font = UIFont(name: Constants.Font.interSemiBold, size: 16)
        button.addTarget(self, action: #selector(presenter.googleSign), for: .touchUpInside)
        return button
    }()
    
    lazy var registrButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.String.dontAc, for: .normal)
        button.titleLabel?.font = UIFont(name: Constants.Font.interMedium, size: 16)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(tapButton(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var hideButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: Constants.Images.eye), for: .normal)
        button.tintColor = UIColor(named: Colors.purplePrimary)
        button.addTarget(self, action: #selector(hidePressed), for: .touchUpInside)
        return button
    }()
    
    lazy var emailImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: Constants.Images.envelope)
        image.tintColor = UIColor(named: Colors.purplePrimary)
        return image
    }()
    
    lazy var passwordImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: Constants.Images.lock)
        image.tintColor = UIColor(named: Colors.purplePrimary)
        return image
    }()
    
    lazy var tapGesture: UITapGestureRecognizer = {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        return tapGesture
    }()
    
    
    
    
    
    
    //MARK: Setup Views
    
    func setupViews() {
        view.backgroundColor = .white
        view.addGestureRecognizer(tapGesture)
        
        
        view.addSubviews(header, underHeader, emailView, passwordView, signButton, registrButton, googleSingIn)
        
        emailView.addSubviews(emailTextField, emailImage)
        
        passwordView.addSubviews(passwordTextField, passwordImage, hideButton)
        
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
}


    