//
//  CategoriesCollectionViewCell.swift
//  NewsToDay
//
//  Created by Mikhail Tedeev on 08.05.2023.
//

import UIKit
import SnapKit

final class CategoriesCollectionViewCell: UICollectionViewCell {
    
    //MARK: - UI Elements
    
    var isChecked: Bool = false {
          didSet {
              // ui to show for the user
              // checkmarkImageView.isHidden = !isChecked
          }
      }
    
    var titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public
    
    func setTitle(category: Category, type: CategoriesCellType) {
        titleLabel.text = "\(category.icon)  \(category.name.capitalized)"
        setupLabel(textColor: UIColor(named: Colors.greyDark.rawValue))
        switch type {
        case .onboarding:
            setupCellForOnboarding()
        case .standard:
            setupCellForStandart()
        }
    }
    
    func didSelected() {
        setupLabel(textColor: .white)
        backgroundColor = UIColor(named: Colors.purplePrimary.rawValue)
    }
    
    func didDeselected() {
        setupLabel(textColor: UIColor(named: Colors.greyDark.rawValue))
        backgroundColor = UIColor(named: Colors.greyLighter.rawValue)
    }
    
    //MARK: - SetupUI
    
    private func setupCellForStandart() {
        backgroundColor = .clear
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 12
        self.layer.borderColor = UIColor(named: Colors.greyLighter.rawValue)?.cgColor
    }
    
    private func setupCellForOnboarding() {
        backgroundColor = UIColor(named: Colors.greyLighter.rawValue)
        self.layer.cornerRadius = 12
    }
    
    private func setupLabel(textColor: UIColor?) {
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: Font.interSemiBold.rawValue, size: 16)
        titleLabel.textColor = textColor
    }
    
    enum CategoriesCellType {
        case onboarding
        case standard
    }
    
    //MARK: - Layout
    
    private func setConstraints() {
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.centerY.equalTo(contentView)
            make.height.equalTo(25)
            make.leading.equalTo(contentView).inset(4)
            make.trailing.equalTo(contentView).inset(4)
        }
    }
}
