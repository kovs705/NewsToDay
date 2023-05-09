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
    
    private var colletctionView: UICollectionView!
    private var discriptionLabel = UILabel()
    
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
        discriptionLabel.text = "Thousands of articles in each category"
        discriptionLabel.textColor = UIColor(named: Colors.greyPrimary)
        discriptionLabel.font = UIFont(name: Fonts.regular, size: 16)
    }
    
    private func setupCollectionView() {
        let layout = UIHelper.createTwoColumnLayout(in: view)
        
        colletctionView = UICollectionView(frame: .zero,
                                           collectionViewLayout: layout)
        colletctionView.dataSource = self
        colletctionView.delegate = self
        colletctionView.register(CategriesCollectionViewCell.self, forCellWithReuseIdentifier: "categories")
    }
    
    //MARK: - Layout
    
    private func setConstraints() {
        addSubViews()
        makeConstraints()
    }
    
    private func addSubViews() {
        let views: [UIView] = [colletctionView, discriptionLabel]
        views.forEach { self.view.addSubview($0) }
    }
    
    private func makeConstraints() {
        colletctionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(32)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.bottom.equalTo(view)
        }
        discriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(8)
            make.leading.equalTo(view).inset(16)
            make.width.equalTo(view)
        }
    }
}

//MARK: - CategriesViewProtocol

extension CategoriesViewController: CategriesViewProtocol {
    
}

//MARK: - UICollectionViewDataSource

extension CategoriesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.categories?.all.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categories", for: indexPath) as! CategriesCollectionViewCell
        guard let category = presenter.categories?.all[indexPath.row] else {
            return cell
        }
        cell.setTitle(category: category)
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension CategoriesViewController: UICollectionViewDelegate {
    
}
