//
//  ProfileVC.swift
//  NewsToDay
//
//  Created by Admin on 10.05.2023.
//

import UIKit
import SnapKit

final class ProfileVC: ProfileExt {
    
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
        setNameUser()
        setEmailUser()
        makeConstrains()
        addTargetForButtons()
        print("UI Code completed")
    }
    
    
}
