//
//  OnboardingViewController.swift
//  NewsToDay
//
//  Created by Mikhail Tedeev on 20.05.2023.
//

import UIKit

class OnboardingViewController: UIViewController {

    private var nextButton = UIButton(type: .system)
    private var onboardingScrollView = UIScrollView()
    private var onboardingPageControl = UIPageControl()
    private var onboardingImageViewArray: [UIImageView] = []
    private var titleLabel = UILabel(textColor: .blackPrimary,
                                     textSize: 24,
                                     font: .interSemiBold,
                                     numberOfLines: 1)
    private var disctiptionLabel = UILabel(textColor: .greyPrimary,
                                           textSize: 16,
                                           font: .interRegular,
                                           numberOfLines: 4)
    
    private var keka = [Onboarding.Image.home.getImage,
                        Onboarding.Image.categories.getImage,
                        Onboarding.Image.bookmarks.getImage]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
    }
    
    //MARK: - Setup UI Elements
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        onboardingPicturesScrollView()
        setupEggPageControl()
        setupOnboardingImageViewArray()
        setupNextButton()
        setupLabels()
    }
    
    private func onboardingPicturesScrollView() {
        onboardingScrollView.isPagingEnabled = true
        onboardingScrollView.showsHorizontalScrollIndicator = false
        onboardingScrollView.delegate = self
        onboardingScrollView.contentSize = CGSize(
            width: Double(Int(view.bounds.width) * keka.count),
            height: 350
        )
    }
    
    private func setupEggPageControl() {
        onboardingPageControl.numberOfPages = keka.count
        onboardingPageControl.currentPageIndicatorTintColor = UIColor(named: Colors.purplePrimary.rawValue)
        onboardingPageControl.pageIndicatorTintColor = UIColor(named: Colors.greyLighter.rawValue)
        onboardingPageControl.addTarget(self, action: #selector(pageControlDidChange), for: .valueChanged)
    }
    
    private func setupOnboardingImageViewArray() {
        for i in 0..<keka.count {
            onboardingImageViewArray.append(UIImageView(image: keka[i]))
            onboardingImageViewArray[i].contentMode = .scaleAspectFit
            onboardingImageViewArray[i].layer.cornerRadius = 12
        }
    }
    
    private func setupNextButton() {
        nextButton.setTitle("Next", for: .normal)
        nextButton.titleLabel?.font = UIFont(name: Font.interSemiBold.rawValue, size: 16)
        nextButton.tintColor = .white
        nextButton.backgroundColor = UIColor(named: Colors.purplePrimary.rawValue)
        nextButton.layer.cornerRadius = 12
        nextButton.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
    }

    private func setupLabels() {
        disctiptionLabel.text = Onboarding.Description.home.getTitle
        titleLabel.text = Onboarding.Title.home.getTitle
        titleLabel.textAlignment = .center
    }
    
    //MARK: - Target Actions
    
    @objc private func pageControlDidChange() {
        let offsetX = view.bounds.width * CGFloat(onboardingPageControl.currentPage)
        onboardingScrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
    @objc private func nextPage() {
        let offsetX = view.bounds.width * CGFloat(onboardingPageControl.currentPage + 1)
        onboardingScrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
    @objc private func pushViewController() {
        let categoriesOnboarding = Coordinator().getCategoriesOnboardingModule()
        navigationController?.pushViewController(categoriesOnboarding, animated: true)
    }
    
    //MARK: - Layout
    
    private func setConstraints() {
        addSubViews()
        makeConstraints()
        onboardingScrollViewsAddSubviews()
    }
    
    private func onboardingScrollViewsAddSubviews() {
        for i in 0..<onboardingImageViewArray.count {
            onboardingScrollView.addSubview(onboardingImageViewArray[i])
            onboardingImageViewArray[i].frame = CGRect(x: Int(view.bounds.width) * i, y: 0, width: Int(view.bounds.width), height: Int(view.bounds.width))
        }
    }
    
    private func addSubViews() {
        let views: [UIView] = [nextButton, onboardingScrollView, onboardingPageControl, titleLabel, disctiptionLabel]
        views.forEach { self.view.addSubview($0) }
    }
    
    private func makeConstraints() {
        onboardingScrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(30)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(400)
        }
        onboardingPageControl.snp.makeConstraints { make in
            make.top.equalTo(onboardingScrollView.snp.bottom)
            make.centerX.equalTo(view)
        }
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
            make.leading.trailing.equalTo(view).inset(20)
            make.height.equalTo(56)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(onboardingPageControl.snp.bottom).offset(16)
            make.leading.trailing.equalTo(view).inset(20)
            make.height.equalTo(30)
        }
        disctiptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(nextButton.snp.top).offset(-8)
            
        }
    }
}

//MARK: - UIScrollViewDelegate

extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        onboardingPageControl.currentPage = Int(onboardingScrollView.contentOffset.x / view.bounds.width)

        switch onboardingPageControl.currentPage {
        case 0:
            nextButton.setTitle("Next", for: .normal)
            nextButton.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
            disctiptionLabel.text = Onboarding.Description.home.getTitle
            titleLabel.text = Onboarding.Title.home.getTitle
        case 1:
            nextButton.setTitle("Next", for: .normal)
            nextButton.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
            disctiptionLabel.text = Onboarding.Description.categories.getTitle
            titleLabel.text = Onboarding.Title.categories.getTitle
        case 2:
            disctiptionLabel.text = Onboarding.Description.bookmarks.getTitle
            titleLabel.text = Onboarding.Title.bookmarks.getTitle
            nextButton.setTitle("Pick categories", for: .normal)
            nextButton.addTarget(self, action: #selector(pushViewController), for: .touchUpInside)
        default:
            disctiptionLabel.text = Onboarding.Description.home.getTitle
            titleLabel.text = Onboarding.Title.home.getTitle
        }
    }
}
