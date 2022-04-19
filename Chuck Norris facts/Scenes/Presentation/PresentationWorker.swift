//
//  PresentationWorker.swift
//  Chuck Norris facts
//
//  Created by Recheteto Junior, Alvaro Jose on 4/15/22.
//

import Foundation
import Network

class PresentationWorker {

    fileprivate var random: RandomJokeUseCase = {
        return RandomJoke()
    }()
    
    func getRandom(_ completion: @escaping (Result<String, Error>) -> Void) {
        random.getRandomJoke { [weak self] result in
            guard let _ = self else {
                return
            }
            switch result {
            case .success(let joke):
                completion(.success(joke))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
