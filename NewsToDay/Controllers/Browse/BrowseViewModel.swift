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
