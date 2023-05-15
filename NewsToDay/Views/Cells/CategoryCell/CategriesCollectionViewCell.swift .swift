//
//  CategoriesCollectionViewCell.swift
//  NewsToDay
//
//  Created by Mikhail Tedeev on 08.05.2023.
//

import UIKit
import SnapKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    //MARK: - UI Elements
    
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
        setupLabel()
        switch type {
        case .onboarding:
            setupCellForOnboarding()
        case .standard:
            setupCellForStandart()
        }
    }
    
    //MARK: - SetupUI
    
    private func setupCellForStandart() {
        backgroundColor = .clear
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 12
        self.layer.borderColor = UIColor(named: Colors.greyLighter)?.cgColor
    }
    
    private func setupCellForOnboarding() {
        backgroundColor = UIColor(named: Colors.greyLighter)
        self.layer.cornerRadius = 12
    }
    
    private func setupLabel() {
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: Constants.Font.interSemiBold, size: 16)
        titleLabel.textColor = UIColor(named: Colors.greyDark)
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
    
    enum CategoriesCellType {
        case onboarding
        case standard
    }
}
