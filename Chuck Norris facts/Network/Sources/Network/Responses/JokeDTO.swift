//
//  File.swift
//  
//
//  Created by Recheteto Junior, Alvaro Jose on 4/15/22.
//

import Foundation

public class JokeDTO: Codable {
    public let categories: [String]
    public let url: String
    public let value: String
}
