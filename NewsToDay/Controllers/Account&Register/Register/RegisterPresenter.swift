//
//  RegisterPresenter.swift
//  NewsToDay
//
//  Created by Kovs on 13.05.2023.
//

import UIKit
import FirebaseAuth

protocol RegisterViewProtocol: AnyObject {
    func hidePressed(sender: UIButton)
    func tapButton()
    
    func showAlert(title: String, message: String)
    func pushTo(vc: UIViewController)
}

protocol RegisterPresenterProtocol: AnyObject {
    
    init(view: RegisterViewProtocol)
    func createUser(email: String, password: String)
    
}

final class RegisterPresenter: RegisterPresenterProtocol {
    weak var view: RegisterViewProtocol?
    
    required init(view: RegisterViewProtocol) {
        self.view = view
    }
    
    func createUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                self.view?.showAlert(title: Constants.String.info, message: error.localizedDescription)
            } else {
                print("Time to go next")
                // navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
            }
        }
    }
    
    
}
