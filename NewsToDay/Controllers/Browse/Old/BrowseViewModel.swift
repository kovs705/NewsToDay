import Foundation

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
            items: [Category(name: "Sport", icon: "1"), Category(name: "Life", icon: "2")].map { .category($0)}),
        BrowseRow(
            index: 1,
            title: "",
            items: [News(source: Source(id: "Apple", name: "Apple company"), author: "Apple", title: "Apple", description: "This is an apple tree", url: "https://google.com", urlToImage: nil, publishedAt: "2023", content: "Zero one to")].map { .news($0)}),
        BrowseRow(
            index: 2,
            title: "",
            items: [News(source: Source(id: "Apple", name: "Apple company"), author: "Apple", title: "Apple", description: "This is an apple tree", url: "https://google.com", urlToImage: nil, publishedAt: "2023", content: "Zero one to")].map { .news($0)})
    ]
}
