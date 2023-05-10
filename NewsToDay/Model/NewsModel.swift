//
//  NewsModel.swift
//  NewsToDay
//
//  Created by Kovs on 07.05.2023.
//

import Foundation

struct Source: Codable, Hashable {
    let id:   String?
    let name: String?
}

struct News: Codable, Hashable {
    let source:             Source
    let author:             String?
    let title, description: String?
    let url:                String?
    let urlToImage:         String?
    let publishedAt:        String?
    let content:            String?
}
