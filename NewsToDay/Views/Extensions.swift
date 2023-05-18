//
//  InterLabel.swift
//  NewsToDay
//
//  Created by Kovs on 17.05.2023.
//

import UIKit

//MARK: - UILabel

extension UILabel {
    convenience init(textColor: Colors, textSize: CGFloat, font: Font, numberOfLines: Int) {
        self.init(frame: .zero)
        self.textColor = UIColor(named: textColor.rawValue)
        self.font = UIFont(name: "\(font.rawValue)", size: textSize)
        self.numberOfLines = numberOfLines
    }
}

//MARK: - UIView

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
