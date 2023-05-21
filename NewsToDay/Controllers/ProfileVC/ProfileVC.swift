//
//  ProfileVC.swift
//  NewsToDay
//
//  Created by Admin on 10.05.2023.
//

import UIKit
import SnapKit

class ProfileVC: ProfileExt {
    
    var presenter: ProfilePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.calculate()
    }
    
}

extension ProfileVC: ProfileViewProtocol {
    func show() {
        // UI code here
        addSubviews()
        setBackground()
        setupProfileImageView()
        setNameUser()
        setEmailUser()
        makeConstrains()
        print("UI Code completed")
    }
    
    
}
