//
//  RegisterVC+Ext.swift
//  NewsToDay
//
//  Created by Kovs on 15.05.2023.
//

import UIKit
import SnapKit
import FirebaseAuth

//MARK: Extension UITextFieldDelegate
extension RegisterVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == passwordSecondTextField {
            UIView.animate(withDuration: 0.3) {
                self.view.center = CGPoint(x: self.originalViewCenter.x, y: self.originalViewCenter.y - 150)
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == passwordSecondTextField {
            UIView.animate(withDuration: 0.3) {
                self.view.center = self.originalViewCenter
            }
        }
    }
}


// MARK: - RegisterVC
class RegisterVC: UIViewController {
    
    var originalViewCenter: CGPoint!
    var presenter: RegisterPresenter!
    
    lazy var header: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Font.interSemiBold, size: 24)
        label.text = Constants.String.welcomeToNews
        return label
    }()
    
    lazy var underHeader: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Font.interRegular, size: 16)
        label.text = Constants.String.hello
        label.numberOfLines = 2
        label.textColor = .systemGray
        return label
    }()
    
    lazy var nameTextField: UITextField = {
        let text = UITextField()
        text.placeholder = Constants.String.name
        text.font = UIFont(name: Constants.Font.interMedium, size: 16)
        text.delegate = self
        return text
    }()
    
    lazy var emailTextField: UITextField = {
        let text = UITextField()
        text.placeholder = Constants.String.email
        text.font = UIFont(name: Constants.Font.interMedium, size: 16)
        text.delegate = self
        return text
    }()
    
    lazy var passwordFirstTextField: UITextField = {
        let text = UITextField()
        text.placeholder = Constants.String.password
        text.font = UIFont(name: Constants.Font.interMedium, size: 16)
        text.isSecureTextEntry = true
        text.delegate = self
        return text
    }()
    
    lazy var passwordSecondTextField: UITextField = {
        let text = UITextField()
        text.placeholder = Constants.String.repeatPas
        text.font = UIFont(name: Constants.Font.interMedium, size: 16)
        text.isSecureTextEntry = true
        text.delegate = self
        return text
    }()
    
    lazy var nameView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.borderColor = UIColor(named: Colors.purplePrimary)?.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    lazy var emailView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.borderColor = UIColor(named: Colors.purplePrimary)?.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    lazy var passwordFirstView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.borderColor = UIColor(named: Colors.purplePrimary)?.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    lazy var passwordSecondView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.borderColor = UIColor(named: Colors.purplePrimary)?.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    lazy var signButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.String.signUp, for: .normal)
        button.backgroundColor = UIColor(named: Colors.purplePrimary)
        button.layer.cornerRadius = 15
        button.titleLabel?.font = UIFont(name: Constants.Font.interSemiBold, size: 16)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        return button
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.String.haveAnAcc, for: .normal)
        button.titleLabel?.font = UIFont(name: Constants.Font.interMedium, size: 16)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(backToSign), for: .touchUpInside)
        return button
    }()
    
    lazy var nameImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: Constants.Images.person)
        image.tintColor = UIColor(named: Colors.purplePrimary)
        return image
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
    
    lazy var passwordImageTwo: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: Constants.Images.lock)
        image.tintColor = UIColor(named: Colors.purplePrimary)
        return image
    }()
    
    lazy var tapGesture: UITapGestureRecognizer = {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        return tapGesture
    }()
    
    lazy var hideButtonOne: UIButton = {
        let button = UIButton(type: .custom)
        button.tag = Constants.String.eight
        button.tintColor = UIColor(named: Colors.purplePrimary)
        button.setImage(UIImage(systemName: Constants.Images.eye), for: .normal)
        button.addTarget(self, action: #selector(hidePressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var hideButtonTwo: UIButton = {
        let button = UIButton(type: .custom)
        button.tintColor = UIColor(named: Colors.purplePrimary)
        button.setImage(UIImage(systemName: Constants.Images.eye), for: .normal)
        button.addTarget(self, action: #selector(hidePressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Setup Views
    
    func setupViews() {
        originalViewCenter = view.center
        navigationItem.hidesBackButton = true
        view.backgroundColor = .white
        view.addGestureRecognizer(tapGesture)
        
        view.addSubviews(header, underHeader, nameView, emailView, passwordFirstView, passwordSecondView, signButton, registerButton)
        
        nameView.addSubviews(nameImage, nameTextField)
        
        emailView.addSubviews(emailImage, emailTextField)
        
        passwordFirstView.addSubviews(passwordImage, passwordFirstTextField, hideButtonOne)
        
        passwordSecondView.addSubviews(passwordImageTwo, passwordSecondTextField, hideButtonTwo)
        
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
            make.right.equalToSuperview().inset(20)
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
            make.right.equalToSuperview().inset(20)
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
            make.right.equalTo(hideButtonTwo.snp.left)
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
            make.right.equalTo(hideButtonOne.snp.left)
        }
        
        signButton.snp.makeConstraints { make in
            make.top.equalTo(passwordSecondView.snp.bottom).offset(64)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(56)
        }
        
        registerButton.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalTo(270)
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
}