//
//  Headline.swift
//  NewsAPI
//
//  Created by Ryan Cohen on 8/8/20.
//

import Foundation

// MARK: - Parameter Enums -

public enum SortOptions: String {
    /// Newest articles come first (default).
    case publishedAt
    /// Articles more closely related to the query come first.
    case relevancy
    /// Articles from popular sources and publishers come first.
    case popularity
}

public enum QueryOptions {
    /// Keywords or a phrase to search for.
    case query(String)
    /// Keywords or phrases to search for in the article title only.
    case titleQuery(String)
    /// The news sources or blogs you want headlines from.
    case sources([String])
    /// Domains (eg bbc.co.uk, techcrunch.com, engadget.com) to restrict the search to.
    case domains([String])
    /// Domains (eg bbc.co.uk, techcrunch.com, engadget.com) to remove from the results.
    case excludeDomains([String])
    /// A date and optional time for the oldest article allowed.
    case fromDate(Date)
    /// A date and optional time for the newest article allowed.
    case toDate(Date)
    /// Code of the language you want to get headlines for.
    case language(Language)
    /// The order to sort the articles in.
    case sortBy(SortOptions)
    /// The category you want to get headlines for.
    case category(Category)
    /// The code of the country you want to get headlines for.
    case country(Country)
    /// The number of results to return per page (request). 20 is the default, 100 is the maximum.
    case pageSize(Int)
    /// Use this to page through the results if the total results found is greater than the page size.
    case page(Int)
    
    var key: String {
        switch self {
        case .query(_):
            return "q"
        case .titleQuery(_):
            return "qInTitle"
        case .sources(_):
            return "sources"
        case .domains(_):
            return "domains"
        case .excludeDomains(_):
            return "excludeDomains"
        case .fromDate(_):
            return "from"
        case .toDate(_):
            return "to"
        case .language(_):
            return "language"
        case .sortBy(_):
            return "sortBy"
        case .category(_):
            return "category"
        case .country(_):
            return "country"
        case .pageSize(_):
            return "pageSize"
        case .page(_):
            return "page"
        }
    }
    
    var value: Any? {
        switch self {
        case .query(let query):
            return query.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
        case .titleQuery(let titleQuery):
            return titleQuery.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
        case .sources(let sources):
            return sources.joined(separator: ",")
        case .domains(let domains):
            return domains.joined(separator: ",")
        case .excludeDomains(let excludeDomains):
            return excludeDomains.joined(separator: ",")
        case .fromDate(let fromDate):
            return fromDate // TODO: Need date string
        case .toDate(let toDate):
            return toDate // TODO: Need date string
        case .language(let language):
            return language
        case .sortBy(let sortBy):
            return sortBy
        case .category(let category):
            return category
        case .country(let country):
            return country
        case .pageSize(let pageSize):
            return pageSize > 100 ? 100 : pageSize
        case .page(let page):
            return page
        }
    }
}

public enum Country: String, Codable {
    case ae, ar, at, au, be, bg, br, ca, ch, cn, co, cu, cz
    case de, eg, fr, gb, gr, hk, hu, id, ie, il, `in`, it, jp
    case kr, lt, lv, ma, mx, my, ng, nl, no, nz, ph, pl, pt, ro
    case rs, ru, sa, se, sg, si, sk, th, tr, tw, ua, us, ve, za
}

public enum Category: String, Codable {
    case business, entertainment, general, health, science, sports, technology
}

public enum Language: String, Codable {
    case ar, de, en, es, fr, he, it, nl, no, pt, ru, se, ud, zh
}

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
