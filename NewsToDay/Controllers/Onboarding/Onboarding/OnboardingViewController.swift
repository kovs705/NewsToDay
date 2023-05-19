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
    private var titleLabel = UILabel()
    private var disctiptionLabel = UILabel()
    
    private var keka = [UIImage(named: "placeholderImage"),
                        UIImage(named: "placeholderImage"),
                        UIImage(named: "placeholderImage")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    //MARK: - Setup UI Elements
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        onboardingPicturesScrollView()
        setupEggPageControl()
    }
    
    private func onboardingPicturesScrollView() {
        onboardingScrollView.isPagingEnabled = true
        onboardingScrollView.showsHorizontalScrollIndicator = false
        onboardingScrollView.delegate = self
        onboardingScrollView.contentSize = CGSize(width: Double(Int(view.bounds.width) * keka.count),height: 350)
    }
    
    private func setupEggPageControl() {
        onboardingPageControl.numberOfPages = keka.count
        onboardingPageControl.currentPageIndicatorTintColor = UIColor(named: Colors.purplePrimary.rawValue)
        onboardingPageControl.pageIndicatorTintColor = UIColor(named: Colors.greyLighter.rawValue)
        onboardingPageControl.addTarget(self, action: #selector(pageControlDidChange), for: .valueChanged)
    }
    
    //MARK: - Target Actions
    
    @objc private func pageControlDidChange() {
        let offsetX = view.bounds.width * CGFloat(onboardingPageControl.currentPage)
        onboardingScrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
    //MARK: - Layout
    
    
}

//MARK: - UIScrollViewDelegate

extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        onboardingPageControl.currentPage = Int(onboardingScrollView.contentOffset.x / view.bounds.width)

//        switch onboardingPageControl.currentPage {
//        case 0:
//        case 1:
//        case 2:
//        default:
//        }
    }
}
