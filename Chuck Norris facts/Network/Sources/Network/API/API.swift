//
//  File.swift
//  
//
//  Created by Recheteto Junior, Alvaro Jose on 4/15/22.
//

import Foundation

enum Api {
    case categories
    case search(_ query: String)
    case random
}

extension Api: EndPointType {
    var baseURL: URL {
        return Settings.enviromentBaseUrl
    }
    
    var path: String {
        switch self {
        case .categories:
            return Endpoint.Jokes.categories
        case .search(let query):
            return Endpoint.Jokes.search + query
        case .random:
            return Endpoint.Jokes.random
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .categories:
            return .get
        case .search:
            return .get
        case .random:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .categories:
            return .request
        case .search:
            return .request
        case .random:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
