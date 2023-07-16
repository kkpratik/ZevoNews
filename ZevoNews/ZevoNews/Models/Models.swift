//
//  Models.swift
//  ZevoNews
//
//  Created by Apple on 15/07/23.
//

import Foundation

// MARK: - Welcome
struct ArticlesData: Codable {
    var status: String?
    var totalResults: Int?
    var articles: [Article]?
}

// MARK: - Article
struct Article: Codable {
    var source: Source?
    var author, title, description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
}

// MARK: - Source
struct Source: Codable {
    var id, name: String?
}
