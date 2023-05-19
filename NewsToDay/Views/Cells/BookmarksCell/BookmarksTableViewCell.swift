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
    private var newsSourse = UILabel()
    private var newsCellBackgroundView = UIView()
    
    //MARK: - Public Setup
    
    func setupCell(news: News) {
        backgroundColor = .clear
        setupViews()
        setLayout()
        guard let title = news.title, let sourse = news.source.name else { return }
        newsTitle.text = title
        newsSourse.text = sourse
    }
    
    func setupImage(news: News) {
        guard let urlToImage = news.urlToImage else { return }
        ImageClient.shared.setImage(
            from: urlToImage,
            placeholderImage: UIImage(named: "placeholderImage")
        ) { [weak self] image in
            guard let image else { return }
            self?.newsImageView.image = image
        }
    }
    
    //MARK: - Setup UI Elements
    
    private func setupViews() {
        setupNewsImageView()
        setupNewsTitle()
        setupNewsSourse()
    }
    
    private func setupNewsImageView() {
        newsImageView.clipsToBounds = true
        newsImageView.layer.cornerRadius = 12
        newsImageView.contentMode = .scaleToFill
    }
    
    private func setupNewsTitle() {
        newsTitle.numberOfLines = 3
        newsTitle.font = UIFont(name: Font.interSemiBold.rawValue, size: 16)
        newsTitle.textColor = UIColor(named: Colors.blackPrimary.rawValue)
    }
    
    private func setupNewsSourse() {
        newsSourse.numberOfLines = 1
        newsSourse.font = UIFont(name: Font.interRegular.rawValue, size: 14)
        newsSourse.textColor = UIColor(named: Colors.greyPrimary.rawValue)
    }
    
    //MARK: - Layout
    
    private func setLayout() {
        addSubviews()
        makeContraints()
    }
    
    private func addSubviews() {
        let allViews = [newsCellBackgroundView, newsImageView, newsTitle, newsSourse]
        allViews.forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func makeContraints() {
        NSLayoutConstraint.activate([
            newsCellBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            newsCellBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            newsCellBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            newsCellBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            newsCellBackgroundView.heightAnchor.constraint(equalToConstant: 96),
            
            newsImageView.leadingAnchor.constraint(equalTo: newsCellBackgroundView.leadingAnchor, constant: 20),
            newsImageView.topAnchor.constraint(equalTo: newsCellBackgroundView.topAnchor),
            newsImageView.bottomAnchor.constraint(equalTo: newsCellBackgroundView.bottomAnchor),
            newsImageView.heightAnchor.constraint(equalTo: newsCellBackgroundView.heightAnchor),
            newsImageView.widthAnchor.constraint(equalTo: newsImageView.heightAnchor),
            
            newsTitle.topAnchor.constraint(equalTo: newsCellBackgroundView.centerYAnchor, constant: -16),
            newsTitle.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 16),
            newsTitle.trailingAnchor.constraint(equalTo: newsCellBackgroundView.trailingAnchor, constant: -20),
            
            newsSourse.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 16),
            newsSourse.bottomAnchor.constraint(equalTo: newsTitle.topAnchor, constant: -8)
        ])
    }
    
//    private func makeContraints() {
//        newsCellBackgroundView.snp.makeConstraints { make in
//            make.trailing.leading.equalToSuperview()
//            make.top.bottom.equalToSuperview().inset(8)
//            make.height.equalTo(96)
//            make.width.equalTo(contentView)
//        }
//
//        newsImageView.snp.makeConstraints { make in
//            make.leading.equalTo(newsCellBackgroundView).inset(20)
//            make.top.equalTo(newsCellBackgroundView)
//            make.bottom.equalTo(newsCellBackgroundView)
//            make.height.equalTo(newsCellBackgroundView.snp.height)
//            make.width.equalTo(newsCellBackgroundView.snp.height)
//        }
//
//        newsTitle.snp.makeConstraints { make in
//            make.top.equalTo(newsCellBackgroundView.snp.centerY)
//            make.leading.equalTo(newsImageView.snp.trailing).offset(16)
//            make.trailing.equalTo(newsCellBackgroundView).inset(20)
//        }
//
//        newsCategory.snp.makeConstraints { make in
//            make.leading.equalTo(newsImageView.snp.trailing).offset(16)
//            make.bottom.equalTo(newsTitle.snp.top).offset(-8)
//        }
//    }
}
