import Foundation

class BrowseViewModel {
    
    let standard = UserDefaults.standard
    var headlines = [News]()

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
    
    
    //TODO: SF Symbols Icons instead mock-names
    var rows: [BrowseRow] = [
        BrowseRow(index: 0, title: "Categories", items: [
            Category(name: Categories.business, icon: "business-icon"),
            Category(name: Categories.entertainment, icon: "entertainment-icon"),
            Category(name: Categories.general, icon: "general-icon"),
            Category(name: Categories.health, icon: "health-icon"),
            Category(name: Categories.science, icon: "science-icon"),
            Category(name: Categories.sports, icon: "sports-icon"),
            Category(name: Categories.technology, icon: "technology-icon")
        ].map { .category($0)}),
        
        BrowseRow(index: 2, title: "Articles", items: [].map { .article($0)})
    ]
    
    func appendNews() {
        rows.append(BrowseRow(index: 1, title: "News", items: headlines.map { .news($0)}))
        
        // get just new articles
    }
    
    func getHeadlines() {
        guard let categories = standard.object(forKey: Keys.categories) as? [Category] else {
            return
        }
        
        for category in categories {
            let request = TopHeadlinesRequest(category: category, page: 1)
            DefaultNetworkService().request(request) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let news):
                    guard let news else { return }
                    self.headlines.append(contentsOf: news.prefix(2))
                    print("Appended \(news) from \(category) category!\\n")
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
//    var rows: [BrowseRow] = [
//        BrowseRow(index: 0, title: "Test", items: )
//        BrowseRow(
//            index: 0,
//            title: "",
//            items: [Category(name: "Sport", icon: "1"), Category(name: "Life", icon: "2")].map { .category($0)}),
//        BrowseRow(
//            index: 1,
//            title: "",
//            items: [News(source: Source(id: "Apple", name: "Apple company"), author: "Apple", title: "Apple", description: "This is an apple tree", url: "https://google.com", urlToImage: nil, publishedAt: "2023", content: "Zero one to"), News(source: Source(id: "sdfsf", name: "Apple company"), author: "Apple", title: "Apple", description: "This is an apple tree", url: "https://google.com", urlToImage: nil, publishedAt: "2023", content: "Zero one to")].map { .news($0)}),
//        BrowseRow(
//            index: 2,
//            title: "",
//            items: [News(source: Source(id: "Gav", name: "Apple company"), author: "Apple", title: "Apple", description: "This is an apple tree", url: "https://google.com", urlToImage: nil, publishedAt: "2023", content: "Zero one to"), News(source: Source(id: "mewow", name: "Apple company"), author: "Apple", title: "Apple", description: "This is an apple tree", url: "https://google.com", urlToImage: nil, publishedAt: "2023", content: "Zero one to")].map { .news($0)})
//    ]
}
