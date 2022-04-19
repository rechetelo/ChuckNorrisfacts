//
//  ParameterEncoding.swift
//  Pods-RNetwork_Tests
//
//  Created by Alvaro Rechetelo on 16/02/19.
//

import Foundation

//MARK: - Typealias
public typealias Parameters = [String:Any]

//MARK: - Protocol
protocol ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public enum ParameterEncoding {
    case urlEncoding
    case jsonEncoding
    case urlAndJsonEncoding
    
    public func encode(urlRequest: inout URLRequest,
                       bodyParameters: Parameters?,
                       urlParameters: Parameters?) throws {
        switch self {
        case .urlEncoding:
            guard let urlParameters = urlParameters else { return }
            try URLParameterEncoder.init().encode(urlRequest: &urlRequest, with: urlParameters)
            
        case .jsonEncoding:
            guard let bodyParameters = bodyParameters else { return }
            try JSONParameterEncoder.init().encode(urlRequest: &urlRequest, with: bodyParameters)
            
        case .urlAndJsonEncoding:
            guard let urlParameters = urlParameters,
                let bodyParameters = bodyParameters else { return }
            try URLParameterEncoder.init().encode(urlRequest: &urlRequest, with: urlParameters)
            try JSONParameterEncoder.init().encode(urlRequest: &urlRequest, with: bodyParameters)
        }
    }
}

//MARK: - Enum
public enum NetworkError: String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameters enconding failed."
    case missingURL = "URL is nil."
}
