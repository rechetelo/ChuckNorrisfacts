//
//  NetworkEnums.swift
//  Pods-RNetwork_Tests
//
//  Created by Alvaro Rechetelo on 16/02/19.
//

import Foundation

public enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case patch  = "PATCH"
    case delete = "DELETE"
}

public enum NetworkHeaderEnconding: String {
    case JSON       = "application/json"
    case ULREncoded = "application/x-www-form-urlencoded"
}
