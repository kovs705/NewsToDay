//
//  ProfilePresenter.swift
//  NewsToDay
//
//  Created by Kovs on 15.05.2023.
//

import UIKit
import SnapKit


protocol ProfileViewProtocol: AnyObject {
    func show()
}

protocol ProfilePresenterProtocol: AnyObject {
    init(view: ProfileViewProtocol)
    func calculate()
}

class ProfilePresenter: ProfilePresenterProtocol {
    
    weak var view: ProfileViewProtocol?
    
    required init(view: ProfileViewProtocol) {
        self.view = view
    }
    
    
    func calculate() {
        // 2 + 2 = 5
        
        self.view?.show()
    }
    
}
