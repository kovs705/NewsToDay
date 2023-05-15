//
//  AccountPresenter.swift
//  NewsToDay
//
//  Created by Kovs on 13.05.2023.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

protocol AccountViewProtocol: AnyObject {
    func pushTo(vc: UIViewController)
    func showAlert(title: String, message: String)
    
    func tapButton(sender: UIButton)
    func hidePressed()
}

protocol AccountPresenterProtocol: AnyObject {
    
    init(view: AccountViewProtocol)
    
    func googleSign()
    func auth(email: String, password: String)
    
    
}

final class AccountPresenter: AccountPresenterProtocol {
    weak var view: AccountViewProtocol?
    
    required init(view: AccountViewProtocol) {
        self.view = view
    }
    
    @objc func googleSign() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: view as! UIViewController) { result, error in
            guard error == nil else { return }
            guard let user = result?.user, let idToken = user.idToken?.tokenString else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            Auth.auth().signIn(with: credential) { result, error in
                self.view?.pushTo(vc: RegisterController())
            }
        }
    }
    
    @objc func auth(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            if let error = error {
                self.view?.showAlert(title: Constants.String.info, message: error.localizedDescription)
            } else {
                print("Time to go next")
                //navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
            }
        }
    }
    
    
    
    
}
