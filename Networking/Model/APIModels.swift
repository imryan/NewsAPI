//
//  Headline.swift
//  NewsAPI
//
//  Created by Ryan Cohen on 8/8/20.
//

import Foundation

// MARK: - Error -

public struct NewsAPIError: Codable {
    let status: String
    let code: String
    let message: String
}

// MARK: - Headline -

public struct Headline: Codable {
    public let status: String?
    public let totalResults: Int?
    public let articles: [Article]?
}

// MARK: - Article -

public struct Article: Codable {
    public let source: Source?
    public let author: String?
    public let title: String?
    public let articleDescription: String?
    public let url: String?
    public let urlToImage: String?
    public let publishedAt: String?
    public let content: String?
    
    enum CodingKeys: String, CodingKey {
        case source = "source"
        case author = "author"
        case title = "title"
        case articleDescription = "description"
        case url = "url"
        case urlToImage = "urlToImage"
        case publishedAt = "publishedAt"
        case content = "content"
    }
}

// MARK: - Source -

public struct Source: Codable {
    public let id: String?
    public let name: String?
}

// MARK: - NewsSource -

public struct NewsSourceContainer: Codable {
    public let status: String?
    public let sources: [NewsSource]?
}

// MARK: - Source -

public struct NewsSource: Codable {
    public let id: String?
    public let name: String?
    public let sourceDescription: String?
    public let url: String?
    public let category: Category?
    public let language: Language?
    public let country: Country?
}

// MARK: - Formatter -

private struct Formatter {
    
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        return formatter
    }
}
