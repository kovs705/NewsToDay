//
//  NewsModel.swift
//  NewsToDay
//
//  Created by Kovs on 07.05.2023.
//

import Foundation

struct NewsModel: Decodable {
    let status: String?
    let totalResults: Int?
    let articles: [News]?
}

struct News: Codable, Hashable {
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

struct Source: Codable, Hashable {
    let id: String?
    let name: String?
}
