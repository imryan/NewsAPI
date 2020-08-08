//
//  Callbacks.swift
//  NewsAPI
//
//  Created by Ryan Cohen on 8/8/20.
//

import Foundation

public typealias HeadlinesCompletion = (_ headline: Headline?, _ error: NewsAPIError?) -> Void
public typealias SourcesCompletion = (_ sources: NewsSourceContainer?, _ error: NewsAPIError?) -> Void
