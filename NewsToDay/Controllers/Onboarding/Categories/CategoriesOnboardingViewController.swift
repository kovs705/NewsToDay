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
    private var getStartedButton = UIButton()
    
    //MARK: - UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setConstraints()
    }
    
    //MARK: - Setup UI
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        self.title = NSLocalizedString("CATEGORIES_ONBORDIN_TITLTE", comment: "Recommendations")
        setupDiscriptionLabel()
        setupCollectionView()
        setupGetStartedButton()
        
        navigationController?.navigationBar.isHidden = false
    }
    
    private func setupDiscriptionLabel() {
        descriptionLabel.text = NSLocalizedString("CATEGORIES_ONBOARDING_SUBTITLE", comment: "Select some of your favourite topics to let us suggest better news for you")
        descriptionLabel.textColor = UIColor(named: Colors.greyPrimary.rawValue)
        descriptionLabel.font = UIFont(name: Font.interRegular.rawValue, size: 16)
        descriptionLabel.numberOfLines = 2
    }
    
    private func setupGetStartedButton() {
        getStartedButton = UIButton(type: .system)
        getStartedButton.backgroundColor = UIColor(named: Colors.purplePrimary.rawValue)
        getStartedButton.layer.cornerRadius = 12
        getStartedButton.setTitle("Get Started", for: .normal)
        getStartedButton.tintColor = .white
        getStartedButton.titleLabel?.font = UIFont(name: Font.interSemiBold.rawValue, size: 16)
        getStartedButton.isEnabled = false
        
        getStartedButton.addTarget(self, action: #selector(getStarted), for: .touchUpInside)
    }
    
    @objc func getStarted() {
        presenter?.getStarted()
    }
    
    private func setupCollectionView() {
        let layout = CategoriesLayout.createTwoColumnLayout(in: view)
        
        collectionView = UICollectionView(frame: .zero,
                                           collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = true
        collectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: "CategoriesOnboardingViewController")
    }
    
    //MARK: - Layout
    
    private func setConstraints() {
        addSubViews()
        makeConstraints()
    }
    
    private func addSubViews() {
        let views: [UIView] = [collectionView, getStartedButton, descriptionLabel]
        views.forEach { self.view.addSubview($0) }
    }
    
    private func makeConstraints() {
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(8)
            make.leading.equalTo(view).inset(16)
            make.width.equalTo(view)
        }
        getStartedButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
            make.leading.trailing.equalTo(view).inset(20)
            make.height.equalTo(56)
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
    func disableButton(isEnabled: Bool) {
        getStartedButton.isEnabled = isEnabled
    }
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let category = presenter.categories?.all[indexPath.row] else { return }
        if let cell = collectionView.cellForItem(at: indexPath) as? CategoriesCollectionViewCell {
            cell.didSelected()
            presenter.select(category)
            cell.isSelected = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let category = presenter.categories?.all[indexPath.row] else { return }
        if let cell = collectionView.cellForItem(at: indexPath) as? CategoriesCollectionViewCell {
            cell.didDeselected()
            presenter.deselect(category)
            cell.isSelected = false
        }
    }
}
