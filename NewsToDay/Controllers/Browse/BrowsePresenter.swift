import Foundation

protocol BrowseViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol BrowsePresenterProtocol: AnyObject {
    init(view: BrowseViewProtocol, networkService: NetworkService)
    var categories: [Category] { get }
    var browseRows: [BrowseRow] { get }
}

final class BrowsePresenter: BrowsePresenterProtocol {
    weak var view: BrowseViewProtocol?
    var networkService: NetworkService!
    var categories = CategoryManager().all
    var browseRows: [BrowseRow] = [
        BrowseRow(
            index: 0,
            title: "",
            items: CategoryManager().all.map { .category($0)}),
        BrowseRow(
            index: 1,
            title: "",
            items: []),
        BrowseRow(
            index: 2,
            title: "",
            items: [])
    ]

    
    required init(view: BrowseViewProtocol, networkService: NetworkService) {
        self.view = view
        self.networkService = networkService
        fetchHead()
        fetchRec()
        print(browseRows[0].items)
    }
    
    func fetchHead() {
        let request = BrowseHeadlinesRequest(category: categories[0])
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let news):
                guard let news else { return }
                self?.browseRows[1] = BrowseRow(index: 1, title: nil,
                                               items: news.map { .news($0)})
                self?.view?.success()
            case .failure(let error):
                self?.view?.failure(error: error)
            }
        }
    }
    
    func fetchRec() {
        let request = BrowseRecomendationRequest(category: categories[6])
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let news):
                guard let news else { return }
                print(news)
                self?.browseRows[2] = BrowseRow(index: 1, title: nil,
                                               items: news.map { .article($0)})
                self?.view?.success()
            case .failure(let error):
                self?.view?.failure(error: error)
            }
        }
    }
}
