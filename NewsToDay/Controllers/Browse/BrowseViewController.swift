import UIKit

protocol SelfConfiguringCell {
    static var id: String { get }
    func configure(with title: String)
}

enum BrowseItem: Hashable {
    case category(String)
    case news(String)
    case article(String)
}

struct BrowseRow: Hashable {
    var index: Int
    var title: String?
    var items: [BrowseItem]
}

struct BrowseContent {
    let category: [String]
    let news: [String]
    let article: [String]
}

private typealias DataSource = UICollectionViewDiffableDataSource<BrowseRow, BrowseItem>
private typealias Snapshot = NSDiffableDataSourceSnapshot<BrowseRow, BrowseItem>

final class BrowseViewController: UIViewController {
    private let searchController = UISearchController()
    private var dataSource: DataSource!
    private var viewModel = BrowseViewModel()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: createCompositionalLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(CategoryCell.self,
                                forCellWithReuseIdentifier: CategoryCell.id)
        collectionView.register(NewsCell.self,
                                forCellWithReuseIdentifier: NewsCell.id)
        collectionView.register(SectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionHeaderView.id)
        return collectionView
    }()
    
    private func configureDataSouce() {
        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case let .category(title): return self.configure(CategoryCell.self, with: title, for: indexPath)
            case let .news(title): return self.configure(NewsCell.self, with: title, for: indexPath)
            case let .article(title): return self.configure(NewsCell.self, with: title, for: indexPath)
            }
        }
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.id, for: indexPath) as! SectionHeaderView
            return headerView
        }
    }
    
    private func reloadData() {
        var snapshot = Snapshot()
        let rows = viewModel.rows
        snapshot.appendSections(rows)
        rows.forEach {
            snapshot.appendItems($0.items, toSection: $0)
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func configure<T: SelfConfiguringCell>(_ cellType: T.Type, with title: String, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: T.id, for: indexPath) as? T
        else { fatalError("Unable to dequeue \(cellType)")}
        cell.configure(with: title)
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigation()
        configureSearchController()
        setupCollectionView()
        configureDataSouce()
        reloadData()
    }
}

extension BrowseViewController {
    func configureSearchController() {
        let image = UIImage(systemName: "slider.horizontal.3")
        searchController.searchBar.setImage(image, for: .bookmark, state: .normal)
        searchController.searchBar.showsBookmarkButton = true
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search"
    }

    func configureNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Browse"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {$0.edges.equalTo(view.safeAreaLayoutGuide)}
    }
}

extension BrowseViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else { return }
        print(query)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
    }
}

extension BrowseViewController: UISearchBarDelegate {
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
    }
}

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

final class BrowseViewModel {
    var content: BrowseContent? {
        didSet {
            rows = [
                BrowseRow(
                    index: 0,
                    title: "",
                    items: (content?.category ?? []).map { .category($0)}),
                BrowseRow(
                    index: 1,
                    title: "",
                    items: (content?.news ?? []).map { .news($0)}),
                BrowseRow(
                    index: 2,
                    title: "",
                    items: (content?.article ?? []).map { .article($0)})
            ]
        }
    }
    var rows: [BrowseRow] = [
        BrowseRow(
            index: 0,
            title: "",
            items: ["Random", "Sport", "Politics", "Life", "Animals", "Nature"].map { .category($0)}),
        BrowseRow(
            index: 1,
            title: "",
            items: ["Random", "Sport", "Politics", "Life", "Animals", "Nature"].map { .news($0)}),
        BrowseRow(
            index: 2,
            title: "",
            items: ["Random", "Sport", "Politics", "Life", "Animals", "Nature"].map { .article($0)})
    ]
}
