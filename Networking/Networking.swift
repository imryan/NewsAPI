//
//  Networking.swift
//  NewsAPI
//
//  Created by Ryan Cohen on 8/8/20.
//

import Foundation

final public class Networking {
    
    // MARK: - Attributes -
    
    let apiKey: String?
    
    enum HTTPMethod: String {
        case get = "GET"
    }
    
    public enum Endpoint: CustomStringConvertible {
        case base
        case topHeadlines
        case everything
        case sources
        
        static let apiVersion: String = "v2"
        static let baseURL: String = "https://newsapi.org/\(Self.apiVersion)"
        
        public var description: String {
            switch self {
            case .base:
                return Self.baseURL
            case .topHeadlines:
                return "\(Self.baseURL)/top-headlines"
            case .everything:
                return "\(Self.baseURL)/everything"
            case .sources:
                return "\(Self.baseURL)/sources"
            }
        }
    }
    
    // MARK: - Initialization
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    // MARK: - Functions -
    
    func get(_ endpoint: Endpoint, with options: [QueryOptions], completion: @escaping HeadlinesCompletion) {
        request(.get, endpoint: endpoint, parameters: getParameters(from: options)) { (headline: Headline?, error: NewsAPIError?) in
            completion(headline, error)
        }
    }
    
    func getSources(with options: [QueryOptions], completion: @escaping SourcesCompletion) {
        request(.get, endpoint: .sources, parameters: getParameters(from: options)) { (sources: NewsSourceContainer?, error: NewsAPIError?) in
            completion(sources, error)
        }
    }
    
    // MARK: - Request Helpers -
    
    private func getParameters(from options: [QueryOptions]) -> [String: Any?] {
        var parameters: [String: Any?] = [:]
        options.forEach { parameters[$0.key] = $0.value }
        return parameters
    }
    
    private func request<T: Codable>(_ method: HTTPMethod, endpoint: Endpoint, parameters: [String: Any?]? = nil, completion: @escaping (_ object: T?, _ error: NewsAPIError?) -> Void) {
        guard let apiKey = self.apiKey else {
            debugPrint("Missing API key.")
            completion(nil, nil)
            return
        }
        
        var urlComponents: URLComponents = URLComponents(string: endpoint.description)!
        if let parameters = parameters {
            let cleanedParameters = parameters.compactMapValues({ $0 })
            var queryItems: [URLQueryItem] = []
            
            for parameter in cleanedParameters {
                let queryItem: URLQueryItem = URLQueryItem(name: parameter.key, value: String(describing: parameter.value))
                queryItems.append(queryItem)
            }
            
            urlComponents.queryItems = queryItems
        }
        
        // TODO: Remove debug code.
        debugPrint("Request URL: \(urlComponents.url?.absoluteString ?? "N/A")")
        
        var urlRequest: URLRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue(apiKey, forHTTPHeaderField: "x-api-key")
        
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            guard let data = data else {
                completion(nil, NewsAPIError(status: "0", code: "-1", message: "No data returned."))
                return
            }
            
            // Decode error data object
            if let errorObject = try? JSONDecoder().decode(NewsAPIError.self, from: data) {
                completion(nil, errorObject)
            }
            
            do {
                // Decode data object
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(object, nil)
            } catch {
                debugPrint(error)
                completion(nil, NewsAPIError(status: "0", code: "-2", message: "Could not decode data object."))
            }
        }.resume()
    }
}
