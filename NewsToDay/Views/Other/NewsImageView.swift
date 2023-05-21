//
//  NewsImageView.swift
//  NewsToDay
//
//  Created by Kovs on 19.05.2023.
//

import UIKit

class NewsImageView: UIImageView {
    
    let cache               = ImageClient.shared.cachedImageForURL
    let placeholderImage    = UIImage(named: "Home2")

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius  = 10
        clipsToBounds       = true
        image               = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setupImage(news: News) {
        guard let urlToImage = news.urlToImage else { return }
        ImageClient.shared.setImage(
            from: urlToImage,
            placeholderImage: UIImage(named: "placeholderImage")
        ) { [weak self] image in
            guard let image else {
                self?.image = image
                return
            }
            self?.image = image
        }
    }
    
}
