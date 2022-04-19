//
//  File.swift
//  
//
//  Created by Recheteto Junior, Alvaro Jose on 4/15/22.
//

import Foundation

public protocol RandomJokeUseCase {
    func getRandomJoke(_ completion: @escaping (Swift.Result<String, Error>) -> Void)
}
