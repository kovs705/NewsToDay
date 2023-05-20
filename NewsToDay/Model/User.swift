//
//  User.swift
//  NewsToDay
//
//  Created by Kovs on 07.05.2023.
//

import Foundation

struct User: Codable {
    let id: String
    let password: String
    let categories: [Category]?
    let region: Web.Region?
}


