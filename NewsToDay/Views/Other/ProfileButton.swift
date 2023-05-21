//
//  ProfileButton.swift
//  NewsToDay
//
//  Created by Kovs on 15.05.2023.
//

import UIKit
import SnapKit

class ProfileButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroundColor: UIColor, title: String, icon: String) {
        self.init(frame: .zero)
        
        self.backgroundColor = backgroundColor
    }
    
    private func configure() {
        
    }
}
