//
//  File.swift
//  
//
//  Created by Recheteto Junior, Alvaro Jose on 4/15/22.
//

import Foundation

public protocol SearchJokesUseCase {
    func getJokes(_ query: String, completion: @escaping (Swift.Result<SearchDTO, Error>) -> Void)
}
