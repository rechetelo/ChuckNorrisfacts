//
//  File.swift
//  
//
//  Created by Recheteto Junior, Alvaro Jose on 4/15/22.
//

import Foundation

/*
 *  Enum that represents property list keys.
 */
enum PlistKey {
    case baseUrl
    
    func value() -> String {
        switch self {
        case .baseUrl:
            return "BASE_URL"
        }
    }
}

/*
 *  Struct that manages environment values from property lists.
 */
struct Environment {
    
    /// Default singleton instance
    static let defaultEnvironment = Environment()
    
    /// Dictionary that retrieves data from the property lists.
    fileprivate var infoDict: [String: Any]  {
        get {
            if let dict = Bundle.main.infoDictionary {
                return dict
            }else {
                print("Plist file not found")
                return [:]
            }
        }
    }
    
    /// Fetches *String* value from given key.
    ///
    /// - Parameters:
    ///     - key: The *key* to be used as getter.
    ///
    /// - Returns: A **String** value found with the key in the property lists.
    func string(_ key: PlistKey) -> String {
        return infoDict[key.value()] as! String
    }
    
    /// Fetches *Bool* value from given key.
    ///
    /// - Parameters:
    ///     - key: The *key* to be used as getter.
    ///
    /// - Returns: A **Bool** value found with the key in the property lists.
    func bool(_ key: PlistKey) -> Bool {
        return infoDict[key.value()] as! Bool
    }
}

