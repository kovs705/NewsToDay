import UIKit

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

private typealias DataSource = UICollectionViewDiffableDataSource<BrowseRow, BrowseItem>
private typealias Snapshot = NSDiffableDataSourceSnapshot<BrowseRow, BrowseItem>

final class BrowseViewController: UIViewController {
    let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigation()
        configureSearchController()
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
