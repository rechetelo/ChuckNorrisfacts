//
//  File.swift
//  
//
//  Created by Recheteto Junior, Alvaro Jose on 4/15/22.
//

import Foundation

public class SearchDTO: Codable {
    let total: Int
    public let result: [JokeDTO]
}
