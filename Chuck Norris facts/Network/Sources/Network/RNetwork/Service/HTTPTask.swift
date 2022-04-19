//
//  HTTPTask.swift
//  Pods-RNetwork_Tests
//
//  Created by Alvaro Rechetelo on 16/02/19.
//

import Foundation

public typealias HTTPHeaders = [String:String]

public enum HTTPTask {
    case request
    
    case requestParameters(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?)
    
    case requestParametersAndHeaders(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?,
        addtionHeaders: HTTPHeaders?)
}
