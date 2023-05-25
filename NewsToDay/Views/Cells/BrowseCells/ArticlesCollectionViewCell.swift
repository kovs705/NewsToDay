//
//  ArticlesCollectionViewCell.swift
//  NewsToDay
//
//  Created by Mikhail Tedeev on 25.05.2023.
//

import UIKit

class ArticlesCell: UICollectionViewCell {
    
    static let id = "ArticlesCell"
    
    //MARK: - UI Elements
    
    private var newsImageView = UIImageView()
    private var newsTitle = UILabel()
    private var newsSourse = UILabel()
    private var newsCellBackgroundView = UIView()
    private var loadingActivityIndicator = UIActivityIndicatorView(style: .medium)
    
    let placeholderImg = UIImage(named: "placeholderImage")
    
    //MARK: - Public Setup
    
    func setupCell(news: News) {
        setupViews()
        setLayout()
        guard let title = news.title, let sourse = news.source.name else { return }
        newsTitle.text = title
        newsSourse.text = sourse
    }
    
    func setupImage(news: News) {
        guard let urlToImage = news.urlToImage else {
            newsImageView.image = placeholderImg
            newsImageView.contentMode = .scaleAspectFill
            loadingActivityIndicator.stopAnimating()
            return
        }
        ImageClient.shared.setImage(
            from: urlToImage,
            placeholderImage: placeholderImg
        ) { [weak self] image in
            guard let image else {
                self?.newsImageView.image = image
                self?.newsImageView.contentMode = .scaleAspectFill
                self?.loadingActivityIndicator.stopAnimating()
                return
            }
            self?.newsImageView.image = image
            self?.newsImageView.contentMode = .scaleAspectFill
            self?.loadingActivityIndicator.stopAnimating()
        }
    }
    
    //MARK: - Setup UI Elements
    
    private func setupViews() {
        backgroundColor = .clear
        loadingActivityIndicator.startAnimating()
        setupNewsImageView()
        setupNewsTitle()
        setupNewsSourse()
    }
    
    private func setupNewsImageView() {
        newsImageView.clipsToBounds = true
        newsImageView.layer.cornerRadius = 12
        newsImageView.contentMode = .scaleAspectFill
        newsImageView.backgroundColor = UIColor(named: Colors.greyLighter.rawValue)
    }
    
    private func setupNewsTitle() {
        newsTitle.numberOfLines = 4
        newsTitle.font = UIFont(name: Font.interSemiBold.rawValue, size: 14)
        newsTitle.textColor = UIColor(named: Colors.blackPrimary.rawValue)
    }
    
    private func setupNewsSourse() {
        newsSourse.numberOfLines = 1
        newsSourse.font = UIFont(name: Font.interRegular.rawValue, size: 11)
        newsSourse.textColor = UIColor(named: Colors.greyPrimary.rawValue)
    }
    
    //MARK: - Layout
    
    private func setLayout() {
        addSubviews()
        makeContraints()
    }
    
    private func addSubviews() {
        let allViews = [newsCellBackgroundView, newsImageView, newsTitle, newsSourse, loadingActivityIndicator]
        allViews.forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func makeContraints() {
        NSLayoutConstraint.activate([
            newsCellBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor),
            newsCellBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            newsCellBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            newsCellBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            newsCellBackgroundView.heightAnchor.constraint(equalToConstant: 96),
            
            newsImageView.leadingAnchor.constraint(equalTo: newsCellBackgroundView.leadingAnchor),
            newsImageView.topAnchor.constraint(equalTo: newsCellBackgroundView.topAnchor),
            newsImageView.bottomAnchor.constraint(equalTo: newsCellBackgroundView.bottomAnchor),
            newsImageView.heightAnchor.constraint(equalTo: newsCellBackgroundView.heightAnchor),
            newsImageView.widthAnchor.constraint(equalTo: newsImageView.heightAnchor),
            
            newsTitle.topAnchor.constraint(equalTo: newsCellBackgroundView.centerYAnchor, constant: -24),
            newsTitle.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 16),
            newsTitle.trailingAnchor.constraint(equalTo: newsCellBackgroundView.trailingAnchor, constant: -20),
            
            newsSourse.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 16),
            newsSourse.bottomAnchor.constraint(equalTo: newsTitle.topAnchor, constant: -8),
            
            loadingActivityIndicator.centerYAnchor.constraint(equalTo: newsImageView.centerYAnchor),
            loadingActivityIndicator.centerXAnchor.constraint(equalTo: newsImageView.centerXAnchor),
            loadingActivityIndicator.widthAnchor.constraint(equalToConstant: 32),
            loadingActivityIndicator.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
}
