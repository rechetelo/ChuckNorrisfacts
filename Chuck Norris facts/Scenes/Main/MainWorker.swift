//
//  MainWorker.swift
//  Chuck Norris facts
//
//  Created by Recheteto Junior, Alvaro Jose on 4/16/22.
//

import Foundation
import Network

class MainWorker {
    
    fileprivate let categories: CategoriesUseCase = {
        return Categories()
    }()
    
    fileprivate let jokes: SearchJokesUseCase = {
        return SearchJokes()
    }()
    
    func getCategories(_ completion: @escaping (Result<[String], Error>) -> Void) {
        categories.getCategories { [weak self] result in
            guard let _ = self else {
                return
            }
            switch result {
            case .success(let list):
                completion(.success(list))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func searchJokes(_ query: String, completion: @escaping (Result<SearchDTO, Error>) -> Void) {
        jokes.getJokes(query) { [weak self] result in
            guard let _ = self else {
                return
            }
            switch result {
            case .success(let search):
                completion(.success(search))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
