//
//  Environemnts.swift
//  Empty Window
//
//  Created by Jerry Li on 2025/3/31.
//

import Foundation

enum SettingsError: Error {
    case keyNotFound(String)
    case typeMismatch(expected: String, key: String)
}

enum Settings {

    enum Key: String, CaseIterable {
        
        case buildConfiguration = "Build Configuration"
        case bundleIdentifier = "CFBundleIdentifier"
        case apiBaseUrl = "Api Base Url"
        case bundleDisplayName = "CFBundleDisplayName"
        case bundleName = "CFBundleName"
    }

    private static func getValue<T>(_ key: String) throws -> T {
        
        let valueToLoad = Bundle.main.object(forInfoDictionaryKey: key)
        if valueToLoad == nil {
            throw SettingsError.keyNotFound(key)
        }

        guard let value = valueToLoad as? T
        else {
            throw SettingsError.typeMismatch(
                expected: "\(T.self)", key: key)
        }

        return value
    }
    
    static func value(for key: Settings.Key) throws -> String {
        return try getValue(key.rawValue)
    }
    
    static var allSettings:[(String, String)] {
        get throws {
            return try Settings.Key.allCases.map {($0.rawValue, try value(for: $0))}
        }
    }
    
    static var buildConfiguraion: String {
        get throws {
            return try value(for: Settings.Key.buildConfiguration)
        }
    }
    
    static var bundleIdentifier: String {
        get throws {
            return try value(for: Settings.Key.bundleIdentifier)
        }
    }
    
    static var apiBaseUrl: String {
        get throws {
            return try value(for: Settings.Key.apiBaseUrl)
        }
    }
    
    static var bundleDisplayName: String {
        get throws {
            return try value(for: Settings.Key.bundleDisplayName)
        }
    }
    
    static var bundleName: String {
        get throws {
            return try value(for: Settings.Key.bundleName)
        }
    }
    
}
