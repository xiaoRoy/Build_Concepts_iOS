//
//  Environemnts.swift
//  Empty Window
//
//  Created by Jerry Li on 2025/3/31.
//

import Foundation

enum ConfigurationError: Error {
    case keyNotFound(String)
    case typeMismatch(expected: String, key: String)
}

enum Configuraions {

    enum Keys {
        static let apiBaseUrl = "API_BASE_URL"
    }

    static func value<T>(_ key: String) throws -> T {

        guard Bundle.main.object(forInfoDictionaryKey: key) != nil else {
            throw ConfigurationError.keyNotFound(key)
        }

        guard let value = Bundle.main.object(forInfoDictionaryKey: key) as? T
        else {
            throw ConfigurationError.typeMismatch(
                expected: "\(T.self)", key: key)
        }

        return value
    }
    
//    static var apiBaseUrl: String {
//        return value(Configuraions.apiBaseUrl)
//    }
    
    static var apiBaseUrl: String {
        get throws {
            return try value(Configuraions.Keys.apiBaseUrl)
        }
    }
}
