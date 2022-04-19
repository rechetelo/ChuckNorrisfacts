//
//  File.swift
//  
//
//  Created by Recheteto Junior, Alvaro Jose on 4/15/22.
//

import Foundation

public protocol CategoriesUseCase {
    func getCategories(_ completion: @escaping (Swift.Result<[String], Error>) -> Void)
}
