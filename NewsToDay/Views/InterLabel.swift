//
//  InterLabel.swift
//  NewsToDay
//
//  Created by Kovs on 17.05.2023.
//

import UIKit

class InterLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    convenience init(textColor: UIColor, textSize: CGFloat, font: String) {
        self.init(frame: .zero)
        self.textColor = textColor
        self.font = UIFont(name: font, size: textSize)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        numberOfLines = 0
    }
}
