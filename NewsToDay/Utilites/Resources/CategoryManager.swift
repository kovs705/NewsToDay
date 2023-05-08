//
//  CategoryManager.swift
//  NewsToDay
//
//  Created by Mikhail Tedeev on 08.05.2023.
//

import Foundation

protocol CategoryManagerProtocol {
    var categories: [Category] { get }
}

class CategoryManager: CategoryManagerProtocol {
    var categories: [Category] = [
        Category(name: <#T##String#>, icon: <#T##String#>, apiName: <#T##String#>)
    ]
}
