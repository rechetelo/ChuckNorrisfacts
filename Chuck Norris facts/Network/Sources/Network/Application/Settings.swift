//
//  File.swift
//  
//
//  Created by Recheteto Junior, Alvaro Jose on 4/15/22.
//

import Foundation

/*
 *  Class representing the settings for the application.
 */
class Settings {
    
    /// Defines the base url to be used in the network layer.
    static var baseURL: String {
        get {
            return Environment.defaultEnvironment.string(.baseUrl)
        }
    }
    
    static var enviromentBaseUrl: URL {
        get {
            return URL(string: self.baseURL)!
        }
    }
}
