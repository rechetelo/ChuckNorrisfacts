//
//  File.swift
//  
//
//  Created by Recheteto Junior, Alvaro Jose on 4/15/22.
//

import Foundation

public class RandomJoke: RandomJokeUseCase {
    
    fileprivate let api = Router<Api>()
    
    public init() {
    }
    
    public func getRandomJoke(_ completion: @escaping (Swift.Result<String, Error>) -> Void) {
        api.request(.random) { data, response, error in
            let manager = NetworkManager()
            switch manager.handleNetworkResponse(response, data, error) {
            case .success:
                guard let data = data else {
                    return
                }
                
                do {
                    let randomJoke = try JSONDecoder().decode(JokeDTO.self, from: data)
                    print(randomJoke.value)
                    completion(.success(randomJoke.value))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
                
            case .failure(let networkFailureError):
                print(networkFailureError.description)
                guard let error = error else {
                    return
                }
                completion(.failure(error))
            }
        }
    }
}
