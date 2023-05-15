//
//  CategoriesOnboardingViewController.swift
//  NewsToDay
//
//  Created by Mikhail Tedeev on 15.05.2023.
//

import UIKit

final class CategoriesOnboardingViewController: UIViewController {

    //MARK: - Property
    
    var presenter: CategoriesOnboardingPresenterProtocol!
    
    //MARK: - UI Elements
    
    private var collectionView: UICollectionView!
    private var descriptionLabel = UILabel()
    
    //MARK: - UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setConstraints()
    }
    
    //MARK: - Setup UI
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        self.title = "Select your favorite topics"
        setupDiscriptionLabel()
        setupCollectionView()
    }
    
    private func setupDiscriptionLabel() {
        descriptionLabel.text = "Select some of your favorite topics to let us suggest better news for you."
        descriptionLabel.textColor = UIColor(named: Colors.greyPrimary)
        descriptionLabel.font = UIFont(name: Constants.Font.interRegular, size: 16)
        descriptionLabel.numberOfLines = 2
    }
    
    private func setupCollectionView() {
        let layout = UIHelper.createTwoColumnLayout(in: view)
        
        collectionView = UICollectionView(frame: .zero,
                                           collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: "CategoriesOnboardingViewController")
    }
    
    //MARK: - Layout
    
    private func setConstraints() {
        addSubViews()
        makeConstraints()
    }
    
    private func addSubViews() {
        let views: [UIView] = [collectionView, descriptionLabel]
        views.forEach { self.view.addSubview($0) }
    }
    
    private func makeConstraints() {
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(8)
            make.leading.equalTo(view).inset(16)
            make.width.equalTo(view)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(32)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.bottom.equalTo(view)
        }
    }
}

//MARK: - CategoriesOnboardingViewProtocol

extension CategoriesOnboardingViewController: CategoriesOnboardingViewProtocol {
    
}

//MARK: - UICollectionViewDataSource

extension CategoriesOnboardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.categories?.all.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesOnboardingViewController", for: indexPath) as! CategoriesCollectionViewCell
        guard let category = presenter.categories?.all[indexPath.row] else {
            return cell
        }
        cell.setTitle(category: category, type: .onboarding)
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension CategoriesOnboardingViewController: UICollectionViewDelegate {
    
}
