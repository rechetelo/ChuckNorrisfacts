//
//  Router.swift
//  Pods-RNetwork_Tests
//
//  Created by Alvaro Rechetelo on 17/02/19.
//

import Foundation

//MARK: - Typelias
public typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()

//MARK: - Protocol
protocol NetworkRouter: AnyObject {
    associatedtype EndPoint : EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}

//MARK: - Class
class Router<EndPoint: EndPointType>: NetworkRouter {
    //MARK - Constants
    private var task: URLSessionTask?
    
    //MARK: - Methods
    func request(_ route: EndPoint, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let  session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                completion(data, response, error)
            })
        } catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        
        let urlStr = route.baseURL.absoluteString as NSString
        let path = route.path
        let urlStrWithPath = urlStr.appendingPathComponent(path)
        let url = URL(string: urlStrWithPath)
        
        var request = URLRequest(
            url: url ?? route.baseURL.appendingPathComponent(route.path),
            cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData,
            timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .request:
                request.setValue(NetworkHeaderEnconding.JSON.rawValue, forHTTPHeaderField: "Content-Type")
            case .requestParameters(let bodyParameters,
                                    let bodyEncoding,
                                    let urlParameters):
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
                
            case .requestParametersAndHeaders(let bodyParameters,
                                              let bodyEncoding,
                                              let urlParameters,
                                              let additionalHeaders):
                
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters?,
                                         bodyEncoding: ParameterEncoding,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request, bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
