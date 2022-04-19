//
//  File.swift
//  
//
//  Created by Recheteto Junior, Alvaro Jose on 4/15/22.
//

import Foundation

public class Categories: CategoriesUseCase {
    
    private let api = Router<Api>()
    
    public init() {
    }
    
    public func getCategories(_ completion: @escaping (Swift.Result<[String], Error>) -> Void) {
        
        api.request(.categories) { data, response, error in
            let manager = NetworkManager()
            switch manager.handleNetworkResponse(response, data, error) {
            case .success:
                guard let data = data else {
                    return
                }
                
                do {
                    let listCategories = try JSONDecoder().decode([String].self, from: data)
                    completion(.success(listCategories))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
                
            case .failure(let networkFailureError):
                guard let error = error else {
                    return
                }
                completion(.failure(error))
            }
        }
    }
}
