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


class AccountController: AccountVC {
    
    //MARK: Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
    }
    
    
}

extension AccountVC: AccountViewProtocol {
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: Constants.String.ok, style: .cancel, handler: nil)
        
        alertController.addAction(action)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func pushTo(vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func tapButton(sender: UIButton) {
        if sender.currentTitle == Constants.String.signIn {
            guard let email = emailTextField.text else { return }
            guard let password = passwordTextField.text else { return }
            
            presenter.auth(email: email, password: password)
        } else {
            pushTo(vc: RegisterController())
        }
    }
    
    @objc func hidePressed() {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
}


