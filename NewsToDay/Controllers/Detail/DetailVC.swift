//
//  DetailVC.swift
//  NewsToDay
//
//  Created by Kovs on 15.05.2023.
//

import UIKit
import SnapKit

class DetailVC: UIViewController {
    
    var presenter: DetailViewPresenterProtocol!
    
    // MARK: - Dynamic UI Properties
    let bookmarkB = UIButton()
    
    let categoryLabel = UILabel(textColor: .greyLighter, textSize: 15, font: .interRegular, numberOfLines: 1)
    let titleLabel = UILabel(textColor: .greyLighter, textSize: 20, font: .interBold, numberOfLines: 0)
    let authorLabel = UILabel(textColor: .greyLighter, textSize: 18, font: .interBold, numberOfLines: 0)
    let bodyLabel = UILabel(textColor: .greyDark, textSize: 17, font: .interRegular, numberOfLines: 0)
    
    let newsImage = NewsImageView(frame: .zero)
    
    // MARK: - Static UI Properties
    let backB = UIButton()
    let shareB = UIButton()
    
    let linkB = UIButton()
    
    let justAuthor = UILabel(textColor: .greyLight, textSize: 13, font: .interMedium, numberOfLines: 0)
    
    
    // MARK: - Main UI Elements
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .systemBackground
        scrollView.alwaysBounceHorizontal = false
        scrollView.contentInsetAdjustmentBehavior = .never
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    lazy var formView: UIView = {
        let formView = UIView()
        formView.backgroundColor = .systemBackground
        formView.layer.cornerRadius = 12
        
        formView.translatesAutoresizingMaskIntoConstraints = false
        
        return formView
    }()
    
    lazy var imageContainer: UIView = {
        let imageContainer = UIView()
        imageContainer.backgroundColor = .clear
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        
        return imageContainer
    }()
    
    lazy var backImage: NewsImageView = {
        let back = NewsImageView(frame: .zero)
        back.backgroundColor = .black
        back.contentMode = .scaleAspectFill
        back.clipsToBounds = true
        
        back.translatesAutoresizingMaskIntoConstraints = false
        
        return back
    }()
    
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
        addViews()
        presenter.setNews()
        
        backImage.addSubview(justAuthor)
        justAuthor.text = "Author"
        justAuthor.translatesAutoresizingMaskIntoConstraints = false
        justAuthor.textAlignment = .left
        
        justAuthor.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(backImage).inset(50)
        }
        
    }
    
    
    // MARK: - Layout functions
    func configureSV() {
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
    }
    
    func configureContainer() {
        let g = scrollView.contentLayoutGuide
        
        NSLayoutConstraint.activate([
            imageContainer.widthAnchor.constraint(equalToConstant: view.bounds.width),
            imageContainer.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.7),
            
            imageContainer.topAnchor.constraint(equalTo: g.topAnchor, constant: -50),
            imageContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func configureImage() {
        let topConstant = backImage.topAnchor.constraint(equalTo: view.topAnchor, constant: -50)
        topConstant.priority = .defaultHigh

        let heightConstraint = backImage.heightAnchor.constraint(greaterThanOrEqualTo: imageContainer.heightAnchor)
        heightConstraint.priority = .required
        
        NSLayoutConstraint.activate([
            backImage.widthAnchor.constraint(equalToConstant: view.bounds.width),
            heightConstraint,
            
            topConstant,
            backImage.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor),
            backImage.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor)

        ])
    }
    
    func configureFormView() {
        let g = scrollView.contentLayoutGuide
        
        NSLayoutConstraint.activate([
            formView.widthAnchor.constraint(equalToConstant: view.bounds.width),
            formView.heightAnchor.constraint(equalToConstant: view.bounds.height - 80),
            
            formView.topAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: -40),
            formView.leadingAnchor.constraint(equalTo: g.leadingAnchor),
            formView.trailingAnchor.constraint(equalTo: g.trailingAnchor),
            formView.bottomAnchor.constraint(equalTo: g.bottomAnchor)
        ])
    }

    
    
    // MARK: - Other functions
    @objc func closeVC() {
        dismiss(animated: true)
    }
    
    func addViews() {
        view.addSubviews(scrollView)
        scrollView.addSubviews(imageContainer, backImage, formView)
        
        configureSV()
        configureContainer()
        configureImage()
        configureFormView()
        
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        formView.addSubview(bodyLabel)
        bodyLabel.textAlignment = .justified
        
        bodyLabel.snp.makeConstraints { make in
            make.leading.equalTo(formView).offset(20)
            make.trailing.equalTo(formView).offset(-20)
            make.top.equalTo(formView).inset(25)
        }
    }
    
    
}

// MARK: - DetailViewProtocol
extension DetailVC: DetailViewProtocol {
    
    
    func setNews(news: News?) {
        // UI code here
        titleLabel.text = news?.title
        bodyLabel.text = news?.description
        
        backImage.downloadImage(fromURL: (news?.urlToImage)!)
        
    }
    
    func isBookmarked(isB: Bool) {
        bookmarkB.setTitle(isB ? "􀉟" : "􀉞", for: .normal)
    }
    
    
}
