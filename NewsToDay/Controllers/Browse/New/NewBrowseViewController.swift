////
////  NewBrowseViewController.swift
////  NewsToDay
////
////  Created by Mikhail Tedeev on 20.05.2023.
////
//
//import UIKit
//import SnapKit
//
//class NewBrowseViewController: UIViewController {
//
//    private var categoriesCollectionView: UICollectionView!
//    private var dataSourse: UICollectionViewDiffableDataSource<BrowseRow, BrowseItem>?
//    private var recomendationsTableView = UITableView()
//    private var searchController = UISearchController()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupViews()
//        setLayouts()
//    }
//    
//    var browseRow = [
//        BrowseRow(index: 0, items: BrowseItem.category([Category(name: "Test", icon: "")])),
//        BrowseRow(index: 0, items: BrowseItem.news([News(source: Source(id: "Test", name: "Test"), author: "Test", title: "Test", description: "Test", url: "Test", urlToImage: "Test", publishedAt: "Test", content: "Test")])),
//        
//]
//    //MARK: - Setup UI Elements
//    
//    private func setupViews() {
//        setupCollectionView()
//        configureSearchController()
//    }
//    
//    private func setupCollectionView() {
//        categoriesCollectionView = UICollectionView(frame: .zero,
//                                                    collectionViewLayout: createCompositionalLayout())
//        categoriesCollectionView.showsVerticalScrollIndicator = false
//        categoriesCollectionView.register(CategoryCell.self,
//                                          forCellWithReuseIdentifier: CategoryCell.id)
//        categoriesCollectionView.register(NewsCell.self,
//                                          forCellWithReuseIdentifier: NewsCell.id)
//        categoriesCollectionView.register(SectionHeaderView.self,
//                                          forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
//                                          withReuseIdentifier: SectionHeaderView.id)
//    }
//    
//    private func setupDataSourse() {
//        dataSourse = UICollectionViewDiffableDataSource<BrowseRow, BrowseItem>(collectionView: categoriesCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
//            switch itemIdentifier {
//            case let .category(category):
//                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.id, for: indexPath) as? CategoryCell else { fatalError("Unable to dequeue CategoryCell")}
//                let currentCategory = category[indexPath.row]
//                // cell.configure(with: currentCategory)
//                
//                return cell
//            case let .news(news):
//                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCell.id, for: indexPath) as? NewsCell else { fatalError("Unable to dequeue NewsCell")}
////                cell.configure(with: news)
//                cell.backgroundColor = .red
//                return cell
//            }
//            
//        })
//    }
//    
//    func configureSearchController() {
////        searchController.searchBar.delegate = self
////        searchController.searchResultsUpdater = self
//        searchController.searchBar.placeholder = "Search"
//        navigationItem.searchController = searchController
//        navigationItem.hidesSearchBarWhenScrolling = true
//    }
//    
//    //MARK: - Layout
//    
//    private func setLayouts() {
//        addSubviews()
//        setConstraints()
//    }
//    
//    private func addSubviews() {
//        let subviewsArray: [UIView] = [categoriesCollectionView, recomendationsTableView]
//        subviewsArray.forEach { self.view.addSubview($0) }
//    }
//    
//    private func setConstraints() {
//        categoriesCollectionView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//    }
//}
//
//extension NewBrowseViewController {
//    func createCompositionalLayout() -> UICollectionViewLayout {
//        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
//            switch sectionIndex {
//            case 0: return self.createCategorySection()
//            case 1: return self.createNewsSection()
//            default: return self.createNewsSection()
//            }
//        }
//        let config = UICollectionViewCompositionalLayoutConfiguration()
//        config.interSectionSpacing = 20
//        layout.configuration = config
//        return layout
//    }
//    
//    func createCategorySection() -> NSCollectionLayoutSection {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(90), heightDimension: .estimated(30))
//        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
//        layoutItem.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .fixed(8), top: .fixed(5), trailing: .fixed(8), bottom: .fixed(5))
//        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .estimated(300), heightDimension: .estimated(50))
//        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
//        let section = NSCollectionLayoutSection(group: layoutGroup)
//        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
//        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
//        return section
//    }
//    
//    func createNewsSection() -> NSCollectionLayoutSection {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
//        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
//        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .estimated(254))
//        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
//        let section = NSCollectionLayoutSection(group: layoutGroup)
//        section.interGroupSpacing = 10
//        section.orthogonalScrollingBehavior = .groupPaging
//        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
//        return section
//    }
//    
//    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
//        let layoutSectionHeaderSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(1),
//            heightDimension: .absolute(54)
//        )
//        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
//            layoutSize: layoutSectionHeaderSize,
//            elementKind: UICollectionView.elementKindSectionHeader,
//            alignment: .top)
//        return layoutSectionHeader
//    }
//}
//
