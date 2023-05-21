//
//  ProfileUIButton.swift
//  NewsToDay
//
//  Created by Mikhail Tedeev on 20.05.2023.
//

import UIKit
import SnapKit

class ProfileUIButton: UIButton {
    
    let profileImageView = UIImageView()
    let profileLabel = UILabel()
    
    init (labelText: String, tintColor: Colors, image: UIImage?) {
        super.init(frame: .zero)
        self.profileLabel.text = labelText
        self.profileLabel.textColor = UIColor(named: tintColor.rawValue)
        self.profileImageView.image = image
        self.profileImageView.tintColor = UIColor(named: tintColor.rawValue)
        setupViews()
        addSubviewsToButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        setupButton()
        setupLabel()
    }
    
    private func setupButton() {
        self.layer.cornerRadius = 12
        self.backgroundColor = UIColor(named: Colors.greyLighter.rawValue)
        profileImageView.contentMode = .scaleAspectFit
    }
    
    private func setupLabel() {
        profileLabel.font = UIFont(name: Font.interSemiBold.rawValue, size: 16)
    }
    
    //MARK: - Layout
    
    private func addSubviewsToButton() {
        let views: [UIView] = [profileImageView, profileLabel]
        views.forEach { self.addSubview($0) }
        makeConstraints()
    }
    
    private func makeConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(18)
            make.trailing.equalToSuperview().inset(14)
            make.width.equalTo(20)
            make.height.equalTo(12)
        }
        profileLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(profileImageView.snp.leading).offset(-8)
            make.width.height.equalTo(24)
        }
    }
}
