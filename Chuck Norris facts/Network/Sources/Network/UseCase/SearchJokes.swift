//
//  File.swift
//  
//
//  Created by Recheteto Junior, Alvaro Jose on 4/15/22.
//

import Foundation

public class SearchJokes: SearchJokesUseCase {
    
    private let api = Router<Api>()
    
    public init() {
    }
    
    public func getJokes(_ query: String, completion: @escaping (Swift.Result<SearchDTO, Error>) -> Void) {
        api.request(.search(query)) { data, response, error in
            let manager = NetworkManager()
            switch manager.handleNetworkResponse(response, data, error) {
            case .success:
                guard let data = data else {
                    return
                }
                do {
                    let listJokes = try JSONDecoder().decode(SearchDTO.self, from: data)
                    completion(.success(listJokes))
                } catch {
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
