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

// MARK: - UILabel

extension UILabel {
    func giveLineSpacing(lineSpacing: CGFloat, lineHeightMultiple: CGFloat = 0.0) {
        guard let text = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        
        let attributedString: NSMutableAttributedString // future attributed string
        
        if let labelAttributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelAttributedText)
        } else {
            attributedString = NSMutableAttributedString(string: text)
        }
        
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
    }
}
