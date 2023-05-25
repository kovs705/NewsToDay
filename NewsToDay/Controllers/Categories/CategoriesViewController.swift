//
//  CategoriesViewController.swift
//  NewsToDay
//
//  Created by Mikhail Tedeev on 07.05.2023.
//

import UIKit
import SnapKit

final class CategoriesViewController: UIViewController {
    
    //MARK: - Property
    
    var presenter: CategoriesPresenterProtocol!
    
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
        setupDiscriptionLabel()
        setupCollectionView()
    }
    
    private func setupDiscriptionLabel() {
        descriptionLabel.text = "Thousands of articles in each category"
        descriptionLabel.textColor = UIColor(named: Colors.greyPrimary.rawValue)
        descriptionLabel.font = UIFont(name: Font.interRegular.rawValue, size: 16)
    }
    
    private func setupCollectionView() {
        let layout = CategoriesLayout.createTwoColumnLayout(in: view)
        
        collectionView = UICollectionView(frame: .zero,
                                           collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: "categories")
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
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(32)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.bottom.equalTo(view)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(8)
            make.leading.equalTo(view).inset(16)
            make.width.equalTo(view)
        }
    }
}

//MARK: - CategriesViewProtocol

extension CategoriesViewController: CategoriesViewProtocol {
    
}

//MARK: - UICollectionViewDataSource

extension CategoriesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.categories?.all.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categories", for: indexPath) as! CategoriesCollectionViewCell
        guard let category = presenter.categories?.all[indexPath.row] else {
            return cell
        }
        cell.setTitle(category: category, type: .standard)
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension CategoriesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedCategory = presenter.categories?.all[indexPath.row] else { return }
        let coordinator = Builder()
        
        let resultViewController = Builder.getResultModule(category: selectedCategory, coordinator: coordinator)
        navigationController?.pushViewController(resultViewController, animated: true)
    }
}
