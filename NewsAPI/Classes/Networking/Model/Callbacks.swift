//
//  Callbacks.swift
//  NewsAPI
//
//  Created by Ryan Cohen on 8/8/20.
//

import Foundation

/// Closure returning optional `Headline` object and an optional `NewsAPIError`.
public typealias HeadlinesCompletion = (_ headline: Headline?, _ error: NewsAPIError?) -> Void

/// Closure returning optional `NewsSourceContainer` object and an optional `NewsAPIError`.
public typealias SourcesCompletion = (_ sources: NewsSourceContainer?, _ error: NewsAPIError?) -> Void
