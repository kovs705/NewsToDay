//
//  NewsImageView.swift
//  NewsToDay
//
//  Created by Kovs on 19.05.2023.
//

import UIKit

class NewsImageView: UIImageView {
    
    let cache               = NewsNetworkClient.shared.cache
    let placeholderImage    = UIImage(named: "Home")

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
    
    func downloadImage(fromURL url: String) {
        NewsNetworkClient.shared.downloadImage(from: url) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.image = image }
        }
    }
    
}
