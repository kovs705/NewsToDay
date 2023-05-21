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
    let symbolConfig = UIImage.SymbolConfiguration(pointSize: 22)
    
    // MARK: - Dynamic UI Properties
    let bookmarkB = UIButton()
    
    let categoryLabel = UILabel(textColor: .white, textSize: 18, font: .interRegular, numberOfLines: 1)
    let titleLabel = UILabel(textColor: .white, textSize: 22, font: .interBold, numberOfLines: 0)
    let authorLabel = UILabel(textColor: .white, textSize: 18, font: .interBold, numberOfLines: 0)
    let bodyLabel = UILabel(textColor: .greyDark, textSize: 18, font: .interRegular, numberOfLines: 0)
    
    let newsImage = NewsImageView(frame: .zero)
    
    // MARK: - Static UI Properties
    let backB = UIButton()
    let shareB = UIButton()
    let linkB = UIButton()
    let webB = UIButton(frame: CGRect(x: 0, y: 0, width: 70, height: 25))
    
    let justAuthor = UILabel(textColor: .greyLight, textSize: 13, font: .interMedium, numberOfLines: 0)
    
    
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
        back.isUserInteractionEnabled = true
        
        back.translatesAutoresizingMaskIntoConstraints = false
        
        return back
    }()
    
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
        addViews()
        presenter.setNews()
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeGesture.direction = .right
        view.addGestureRecognizer(swipeGesture)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    
    // MARK: - UI Elements functions
    func configureBodyLabel() {
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        formView.addSubview(bodyLabel)
        bodyLabel.textAlignment = .justified
        
        bodyLabel.snp.makeConstraints { make in
            make.leading.equalTo(formView).offset(20)
            make.trailing.equalTo(formView).offset(-20)
            make.top.equalTo(formView).inset(25)
        }
    }
    
    func configureJustAuthor() {
        backImage.addSubview(justAuthor)
        justAuthor.text = "Author"
        justAuthor.translatesAutoresizingMaskIntoConstraints = false
        justAuthor.textAlignment = .left
        
        justAuthor.snp.makeConstraints { make in
            make.bottom.equalTo(backImage).inset(60)
            make.leading.equalTo(backImage).inset(25)
        }
    }
    
    func configureTitleLabel() {
        backImage.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .natural
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(authorLabel.snp.top).offset(-25)
            make.leading.equalTo(backImage.snp.leading).inset(25)
            make.trailing.equalTo(backImage.snp.trailing).offset(-25)
        }
    }
    
    func configureAuthorNameLabel() {
        backImage.addSubview(authorLabel)
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.textAlignment = .natural
        
        authorLabel.snp.makeConstraints { make in
            make.bottom.equalTo(justAuthor.snp.top).offset(-5)
            make.leading.equalTo(backImage.snp.leading).inset(25)
            make.trailing.equalTo(backImage.snp.trailing).offset(25)
        }
    }
    
    func configureCategoryLabel() {
        
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: 25))
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = UIColor(named: Colors.purplePrimary.rawValue)
        container.layer.cornerRadius = 15
        
        backImage.addSubview(container)
        container.addSubview(categoryLabel)
        
        // backImage.addSubview(categoryLabel)
//        categoryLabel.backgroundColor = UIColor(named: Colors.purplePrimary.rawValue)
//        categoryLabel.layer.cornerRadius = 10
//
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false

        categoryLabel.textAlignment = .center
        
        
        container.snp.makeConstraints { make in
            make.bottom.equalTo(titleLabel.snp.top).offset(-22)
            make.leading.equalTo(backImage.snp.leading).inset(25)
            
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(container).inset(5)
            make.leading.trailing.equalTo(container).inset(15)
        }
        
    }
    
    func configureShareButton() {
        backImage.addSubview(shareB)
        backImage.bringSubviewToFront(shareB)
        shareB.translatesAutoresizingMaskIntoConstraints = false
        
        shareB.setImage(UIImage(systemName: "arrowshape.turn.up.forward", withConfiguration: symbolConfig), for: .normal)
        shareB.tintColor = .white
        
        shareB.addTarget(self, action: #selector(openSafari), for: .touchUpInside)
        shareB.isUserInteractionEnabled = true
        
        shareB.snp.makeConstraints { make in
            make.top.equalTo(bookmarkB.snp.bottom).offset(25)
            make.trailing.equalTo(backImage.snp.trailing).inset(25)
        }
    }
    
    func configureBookmarkButton() {
        backImage.addSubview(bookmarkB)
        backImage.bringSubviewToFront(bookmarkB)
        
        bookmarkB.translatesAutoresizingMaskIntoConstraints = false
        bookmarkB.tintColor = .white
        
        bookmarkB.addTarget(self, action: #selector(bookmarkIt), for: .touchUpInside)
        bookmarkB.isUserInteractionEnabled = true
        
        bookmarkB.snp.makeConstraints { make in
            make.top.equalTo(backImage.snp.top).offset(120)
            make.trailing.equalTo(backImage.snp.trailing).inset(25)
        }
    }
    
    func configureBackButton() {
        backImage.addSubview(backB)
        backImage.bringSubviewToFront(backB)
        backB.translatesAutoresizingMaskIntoConstraints = false
        
        backB.setImage(UIImage(systemName: "arrow.backward", withConfiguration: symbolConfig), for: .normal)
        backB.tintColor = .white
        
        backB.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        backB.isUserInteractionEnabled = true
        
        backB.snp.makeConstraints { make in
            make.top.equalTo(backImage.snp.top).offset(120)
            make.leading.equalTo(backImage.snp.leading).inset(25)
        }
    }
    
    
    // MARK: - Main Layout functions
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
        navigationController?.popViewController(animated: true)
    }
    
    @objc func gav() {
        print("gav")
    }
    
    @objc func bookmarkIt() {
        presenter?.bookmarkIt()
    }
    
    @objc func openSafari() {
        presenter?.openLink(vc: self)
        print("open safari")
    }
    
    @objc func handleSwipeGesture(_ gestureRecognizer: UISwipeGestureRecognizer) {
        if gestureRecognizer.direction == .right {
            navigationController?.popViewController(animated: true)
        }
    }
    
    func addViews() {
        view.addSubviews(scrollView)
        scrollView.addSubviews(imageContainer, backImage, formView)
        
        // base
        configureSV()
        configureContainer()
        configureImage()
        configureFormView()
       
        // labels
        configureBodyLabel()
        configureJustAuthor()
        configureAuthorNameLabel()
        configureTitleLabel()
        configureCategoryLabel()
        
        // buttons
        configureBackButton()
        configureBookmarkButton()
        configureShareButton()
        
    }
    
    
}

// MARK: - DetailViewProtocol
extension DetailVC: DetailViewProtocol {
    
    
    func setNews(news: News?) {
        // UI code here
        titleLabel.text = news?.title
        authorLabel.text = news?.author
        if news?.description == nil {
            bodyLabel.text = "Article's content is empty, click on the link below to read more.."
        } else {
            bodyLabel.text = news?.description
        }
        categoryLabel.text = news?.source.name
        
        backImage.setupImage(news: news!)
        
    }
    
    func isBookmarked(isB: Bool) {
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 22)
        bookmarkB.setImage(UIImage(systemName: isB ? "bookmark.fill" : "bookmark", withConfiguration: symbolConfig), for: .normal)
        print(isB ? "Bookmarked" : "Not")
    }
    
    
}
