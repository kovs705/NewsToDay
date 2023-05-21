//
//  NewBrowseViewController.swift
//  NewsToDay
//
//  Created by Mikhail Tedeev on 20.05.2023.
//

import UIKit
import SnapKit

class NewBrowseViewController: UIViewController {

    private var categoriesCollectionView = UICollectionView()
    private var recomendationsTableView = UITableView()
    private var searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setLayouts()
    }
    
    //MARK: - Setup UI Elements
    
    private func setupViews() {
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        
    }
    
    //MARK: - Layout
    
    private func setLayouts() {
        addSubviews()
        setConstraints()
    }
    
    private func addSubviews() {
        let subviewsArray: [UIView] = [categoriesCollectionView, recomendationsTableView]
        subviewsArray.forEach { self.view.addSubview($0) }
    }
    
    private func setConstraints() {
        
    }
}

extension NewBrowseViewController {
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            switch sectionIndex {
            case 0: return self.createCategorySection()
            case 1: return self.createNewsSection()
            default: return self.createArticleSection()
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }
    
    func createCategorySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(90), heightDimension: .estimated(30))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .fixed(8), top: .fixed(5), trailing: .fixed(8), bottom: .fixed(5))
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .estimated(300), heightDimension: .estimated(50))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        let section = NSCollectionLayoutSection(group: layoutGroup)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
        return section
    }
    
    func createNewsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .estimated(254))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        let section = NSCollectionLayoutSection(group: layoutGroup)
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        return section
    }
    
    func createArticleSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        let section = NSCollectionLayoutSection(group: layoutGroup)
        section.boundarySupplementaryItems = [createSectionHeader()]
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        return section
    }
    
    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(54)
        )
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: layoutSectionHeaderSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        return layoutSectionHeader
    }
}

