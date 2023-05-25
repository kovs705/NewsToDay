import UIKit

enum BrowseItem: Hashable {
    case category(Category)
    case news(News)
    case article(News)
}

struct BrowseRow: Hashable {
    var index: Int
    var title: String?
    var items: [BrowseItem]
}

struct BrowseContent {
    let category: [Category]
    let news: [News]
    let article: [News]
}

private typealias DataSource = UICollectionViewDiffableDataSource<BrowseRow, BrowseItem>
private typealias Snapshot = NSDiffableDataSourceSnapshot<BrowseRow, BrowseItem>

final class BrowseViewController: UIViewController {
    private let searchController = UISearchController()
    private var dataSource: DataSource!
    var presenter: BrowsePresenterProtocol!
    let standard = UserDefaults.standard
    let coordinator = Builder()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: createCompositionalLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(CategoryCell.self,
                                forCellWithReuseIdentifier: CategoryCell.id)
        collectionView.register(NewsCell.self,
                                forCellWithReuseIdentifier: NewsCell.id)
        collectionView.register(ArticlesCell.self,
                                forCellWithReuseIdentifier: ArticlesCell.id)
        collectionView.register(SectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionHeaderView.id)
        return collectionView
    }()
    
    private func configureDataSouce() {
        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case let .category(category):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.id, for: indexPath) as? CategoryCell else { fatalError("Unable to dequeue CategoryCell")}
                cell.configure(with: category)
                return cell
            case let .news(news):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCell.id, for: indexPath) as? NewsCell else { fatalError("Unable to dequeue NewsCell")}
                cell.setupCell(news: news)
                cell.setupImage(news: news)
                return cell
            case let .article(article):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticlesCell.id, for: indexPath) as? ArticlesCell else { fatalError("Unable to dequeue NewsCell")}
                cell.setupCell(news: article)
                cell.setupImage(news: article)
                return cell
            }
        }
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.id, for: indexPath) as! SectionHeaderView
            return headerView
        }
    }
    
    private func reloadData() {
        var snapshot = Snapshot()
        let rows = presenter.browseRows
        snapshot.appendSections(rows)
        rows.forEach {
            snapshot.appendItems($0.items, toSection: $0)
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    //MARK: - UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        print("Checking")
//        checkOnboarding()
        
        configureSearchController()
        configureNavigation()
        setupCollectionView()
        configureDataSouce()
        reloadData()
    }
    
    
    private func pushToOnboarding() {
        navigationController?.pushViewController((coordinator.getOnboardingModule()), animated: true)
    }
    
    private func checkOnboarding() {
        guard let isOnboarded = standard.object(forKey: Keys.onboarding) as? Bool else {
            pushToOnboarding()
            return
        }
        
        if isOnboarded == false {
            pushToOnboarding()
        }
    }
}

//MARK: - configureSearchController

extension BrowseViewController {
    func configureSearchController() {
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search"
    }

    func configureNavigation() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {$0.edges.equalTo(view.safeAreaLayoutGuide)}
    }
}

//MARK: - UISearchResultsUpdating

extension BrowseViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else { return }
        print(query)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
    }
}

//MARK: - UISearchBarDelegate

extension BrowseViewController: UISearchBarDelegate {
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
    }
}

//MARK: - BrowseViewProtocol

extension BrowseViewController: BrowseViewProtocol {
    func success() {
        reloadData()
    }
    
    func failure(error: Error) {
        reloadData()
    }
}

//MARK: - UICollectionViewLayout

extension BrowseViewController {
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
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.67), heightDimension: .estimated(256))
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
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(100))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        let section = NSCollectionLayoutSection(group: layoutGroup)
        section.boundarySupplementaryItems = [createSectionHeader()]
        section.orthogonalScrollingBehavior = .groupPaging
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

