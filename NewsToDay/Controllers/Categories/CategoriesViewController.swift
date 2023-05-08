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
    
    private var colletctionView = UICollectionView()
    private var discriptionLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addSubViews()
    }
    
    //MARK: - Setup UI
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupDiscriptionLabel()
    }
    
    private func setupDiscriptionLabel() {
        discriptionLabel.text = "Thousands of articles in each category"
        discriptionLabel.textColor = UIColor(named: Colors.greyPrimary)
        discriptionLabel.font = UIFont(name: Fonts.regular, size: 16)
    }
    
    private func setupCollectionView() {
        colletctionView.dataSource = self
        colletctionView.delegate = self
        colletctionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "categories")
    }
    
    //MARK: - Layout
    
    private func addSubViews() {
        let views: [UIView] = [colletctionView, discriptionLabel]
        views.forEach { self.view.addSubview($0) }
    }
    
    private func makeConstraints() {
        colletctionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        discriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.bottom)
        }
    }
}

//MARK: - CategriesViewProtocol

extension CategoriesViewController: CategriesViewProtocol {
    
}

//MARK: - UICollectionViewDataSource

extension CategoriesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categories", for: indexPath)
        cell.backgroundColor = .systemRed
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension CategoriesViewController: UICollectionViewDelegate {
    
}
