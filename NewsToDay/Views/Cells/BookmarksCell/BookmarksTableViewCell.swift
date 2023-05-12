//
//  BookmarksTableViewCell.swift
//  NewsToDay
//
//  Created by Mikhail Tedeev on 12.05.2023.
//

import UIKit
import SnapKit

class BookmarksTableViewCell: UITableViewCell {

    //MARK: - UI Elements
    
    private var newsImageView = UIImageView()
    private var newsTitle = UILabel()
    private var newsCategory = UILabel()
    private var newsCellBackgroundView = UIView()
    
    //MARK: - Public Setup
    
    func setupCell(image: UIImage, title: String, category: String) {
        setupNewsImageView(image)
        setupNewsTitle(title)
        setupNewsCategory(category)
        backgroundColor = .clear
        setLayout()
    }
    
    //MARK: - Setup UI Elements
    
    private func setupNewsImageView(_ image: UIImage) {
        newsImageView.image = image
        newsImageView.contentMode = .scaleToFill
        newsImageView.layer.cornerRadius = 12
    }
    
    private func setupNewsTitle(_ text: String) {
        newsTitle.text = text
        newsTitle.numberOfLines = 2
        newsTitle.font = UIFont(name: Constants.Font.interSemiBold, size: 16)
        newsTitle.textColor = UIColor(named: Colors.blackPrimary)
    }
    
    private func setupNewsCategory(_ text: String) {
        newsCategory.text = text
        newsCategory.numberOfLines = 1
        newsCategory.font = UIFont(name: Constants.Font.interRegular, size: 14)
        newsCategory.textColor = UIColor(named: Colors.greyPrimary)
    }
    
    //MARK: - Layout
    
    private func setLayout() {
        addSubviews()
        makeContraints()
    }
    
    private func addSubviews() {
        let allViews = [newsCellBackgroundView, newsImageView, newsTitle, newsCategory]
        allViews.forEach { contentView.addSubview($0) }
    }
    
    private func makeContraints() {
        newsCellBackgroundView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(8)
            make.height.equalTo(96)
            make.width.equalTo(contentView)
        }
        
        newsImageView.snp.makeConstraints { make in
            make.leading.equalTo(newsCellBackgroundView).inset(20)
            make.top.equalTo(newsCellBackgroundView)
            make.bottom.equalTo(newsCellBackgroundView)
            make.height.equalTo(newsCellBackgroundView.snp.height)
            make.width.equalTo(newsCellBackgroundView.snp.height)
        }
        
        newsTitle.snp.makeConstraints { make in
            make.top.equalTo(newsCellBackgroundView.snp.centerY)
            make.leading.equalTo(newsImageView.snp.trailing).offset(16)
            make.trailing.equalTo(newsCellBackgroundView).inset(20)
        }
        
        newsCategory.snp.makeConstraints { make in
            make.leading.equalTo(newsImageView.snp.trailing).offset(16)
            make.bottom.equalTo(newsTitle.snp.top).offset(-8)
        }
    }
}
