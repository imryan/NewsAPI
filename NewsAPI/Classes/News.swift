//
//  News.swift
//  NewsAPI
//
//  Created by Ryan Cohen on 8/8/20.
//

import Foundation

open class News {
    
    // MARK: - Attributes -
    
    /// Networking helper
    private let networking: Networking?
    
    // MARK: - Initialization -
    
    /// Initialization
    ///
    /// - Parameter apiKey: Required API key from NewsAPI.
    public init(apiKey: String) {
        self.networking = Networking(apiKey: apiKey)
    }
    
    // MARK: - Functions -
    
    /// Get top headlines
    ///
    /// This endpoint provides live top and breaking headlines for a country, specific category
    /// in a country, single source, or multiple sources. You can also search with keywords.
    /// Articles are sorted by the earliest date published first.
    /// This endpoint is great for retrieving headlines for display on news tickers or similar.
    ///
    /// - Parameters:
    ///   - options: Array of `QueryOptions` items for fitlering results.
    ///     Accepted options: (`.category`, `.language`, `.country`, `.sources`, `.query`, `.pageSize`, `.page`)
    ///   - completion: Closure returning optional `Headline` object and an optional `NewsAPIError`.
    open func getTopHeadlines(with options: [QueryOptions], completion: @escaping HeadlinesCompletion) {
        networking?.get(.topHeadlines, with: options, completion: completion)
    }
    
    /// Get everything
    ///
    /// Search through millions of articles from over 50,000 large and small news sources and blogs.
    /// This includes breaking news as well as lesser articles.
    /// This endpoint suits article discovery and analysis, but can be used to retrieve articles for display, too.
    ///
    /// - Parameters:
    ///   - options: Array of `QueryOptions` items for fitlering results.
    ///     Accepted options: (`.category`, `.language`, `.country`, `.sources`, `.query`, `.pageSize`, `.page`,
    ///     `.titleQuery`, `.domains`, `.excludeDomains`, `.fromDate`, `.toDate`, `sortBy`)
    ///   - completion: Closure returning optional `Headline` object and an optional `NewsAPIError`.
    open func getEverything(with options: [QueryOptions], completion: @escaping HeadlinesCompletion) {
        networking?.get(.everything, with: options, completion: completion)
    }
    
    /// Get sources
    ///
    /// This endpoint returns the subset of news publishers that top headlines (/v2/top-headlines) are available from.
    ///  It's mainly a convenience endpoint that you can use to keep track of the publishers available on the API,
    ///  and you can pipe it straight through to your users.
    ///
    /// - Parameters:
    ///   - options: Array of `QueryOptions` items for fitlering results.
    ///     Accepted options: (`.category`, `.language`, `.country`)
    ///   - completion: Closure returning optional `Headline` object and an optional `NewsAPIError`.
    open func getSources(with options: [QueryOptions], completion: @escaping SourcesCompletion) {
        networking?.getSources(with: options, completion: completion)
    }
    
    /// Shorthand function for fetching top headlines/everything/sources
    ///
    /// - Parameters:
    ///   - type: `EndpointType` type for specifying the endpoint.
    ///   - options: Array of `QueryOptions` items for fitlering results.
    ///   - completion: Closure returning optional `Headline` object and an optional `NewsAPIError`.
    open func get(_ type: Networking.Endpoint, with options: [QueryOptions], completion: @escaping HeadlinesCompletion) {
        switch type {
        case .topHeadlines:
            getTopHeadlines(with: options, completion: completion)
        case .everything:
            getEverything(with: options, completion: completion)
        case .sources:
            fatalError("Calling sources URL unavailable from this function.")
        case .base:
            fatalError("Calling base URL unavailable from this function..")
        }
    }
}
