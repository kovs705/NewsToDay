//
//  RegisterController.swift
//  NewsToDay
//
//  Created by sidzhe on 08.05.2023.
//

import UIKit
import SnapKit
import FirebaseAuth

class RegisterController: RegisterVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
}

extension RegisterVC: RegisterViewProtocol {
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: Constants.String.ok, style: .cancel, handler: nil)
        
        alertController.addAction(action)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    @objc func hidePressed(sender: UIButton) {
        if sender.tag == Constants.String.eight {
            passwordFirstTextField.isSecureTextEntry = !passwordFirstTextField.isSecureTextEntry
        } else {
            passwordSecondTextField.isSecureTextEntry = !passwordSecondTextField.isSecureTextEntry
        }
    }
    
    @objc func backToSign() {
        navigationController?.pushViewController(AccountController(), animated: true)
    }
    
    func pushTo(vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func tapButton() {
        if passwordFirstTextField.text != passwordSecondTextField.text {
            showAlert(title: Constants.String.info, message: Constants.String.errorPassword)
        }
        
        guard let email = emailTextField.text else { return }
        guard let password = passwordFirstTextField.text else { return }
        
        presenter.createUser(email: email, password: password)
    }
    
    
}
