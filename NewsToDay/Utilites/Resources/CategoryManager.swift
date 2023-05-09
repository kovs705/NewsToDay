//
//  CategoryManager.swift
//  NewsToDay
//
//  Created by Mikhail Tedeev on 08.05.2023.
//

import Foundation

protocol CategoryManagerProtocol {
    var all: [Category] { get }
}

class CategoryManager: CategoryManagerProtocol {
    var all: [Category] = [
        Category(name: Categories.business,
                 icon: "📈"),
        Category(name: Categories.entertainment,
                 icon: "🎥"),
        Category(name: Categories.general,
                 icon: "⚖️"),
        Category(name: Categories.health,
                 icon: "🏃🏼‍♀️"),
        Category(name: Categories.science,
                 icon: "🧬"),
        Category(name: Categories.technology,
                 icon: "📱"),
        Category(name: Categories.sports,
                 icon: "🏈"),
    ]
}
