//
//  EndPointType.swift
//  Pods-RNetwork_Tests
//
//  Created by Alvaro Rechetelo on 16/02/19.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
