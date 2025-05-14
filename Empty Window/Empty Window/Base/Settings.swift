//
//  Environemnts.swift
//  Empty Window
//
//  Created by Jerry Li on 2025/3/31.
//

import Foundation

protocol SettingsProvider {
    func value(for key: String) throws -> String
}

struct BundleSettingsProvider: SettingsProvider {

    fileprivate static func getValue<T>(_ key: String) throws -> T {

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

    func value(for key: String) throws -> String {
        return try BundleSettingsProvider.getValue(key)
    }
}

struct ConditionalCompilationSettingsProvider: SettingsProvider {

    static let firebaseKey: String = Settings.Key.firebaseKey.rawValue

    fileprivate static func getValue(_ key: String) throws -> String {
        let settings: [String: String]
        #if DEBUG
            settings = DebugSettingsHolder.settingsDictionary
        #else
            settings = ReleaseSettingsHolder.settingsDictionary
        #endif
        guard let value = settings[key] else {
            throw SettingsError.keyNotFound(key)
        }
        return value
    }

    func value(for key: String) throws -> String {
        try ConditionalCompilationSettingsProvider.getValue(key)
    }

    protocol SettingsHolder {
        static var settingsDictionary: [String: String] { get }
    }

    struct DebugSettingsHolder: SettingsHolder {
        static var settingsDictionary: [String: String] = [
            firebaseKey: "degbu-firebase-key"
        ]
    }

    struct ReleaseSettingsHolder: SettingsHolder {
        static var settingsDictionary: [String: String] = [
            firebaseKey: "release-firebase-key"
        ]
    }
}

struct SchemeEnvironmentVariableProvider: SettingsProvider {

    fileprivate static func getValue(_ key: String) throws -> String {
        #if DEBUG
            guard let value = ProcessInfo.processInfo.environment[key] else {
                throw SettingsError.keyNotFound(key)
            }
            return value
        #else
            return "Only availble in Debug"
        #endif
    }

    func value(for key: String) throws -> String {
        return try SchemeEnvironmentVariableProvider.getValue(key)
    }
}

struct BuildScriptConfigsProvider: SettingsProvider {

    fileprivate static func getValue(_ key: String) throws -> String {
        guard let value = ConfigsHolder.holder[key] else {
            throw SettingsError.keyNotFound(key)
        }
        return value
    }

    func value(for key: String) throws -> String {
        return try BuildScriptConfigsProvider.getValue(key)
    }

    private struct ConfigsHolder {
        static let remoteConfiKey = Settings.Key.remoteConfiKey.rawValue
        static let holder: [String: String] = [
            remoteConfiKey: Configs.remoteConfiKey
        ]
    }
}

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
        case xApiKey = "X API Key"
        case firebaseKey = "Firebase Key"
        case registryApiKey = "REGISTRY_API_KEY"
        case remoteConfiKey = "REMOTE_CONFIG_KEY"
    }

    private static func value(for key: Settings.Key) throws -> String {
        return try BundleSettingsProvider.getValue(key.rawValue)
    }

    private static let providers: [SettingsProvider] = [
        BundleSettingsProvider(),
        ConditionalCompilationSettingsProvider(),
        SchemeEnvironmentVariableProvider(),
        BuildScriptConfigsProvider(),
    ]

    static var allSettings: [(String, String)] {
        get throws {
            return try Settings.Key.allCases.map({
                (key) -> (String, String) in
                let rawKey = key.rawValue
                var resultValue: String? = nil
                for provider in providers {
                    if let value = try? provider.value(for: rawKey) {
                        resultValue = value
                        break
                    }

                }
                guard let resultValue else {
                    throw SettingsError.keyNotFound(rawKey)
                }
                return (rawKey, resultValue)
            })

        }
    }

    static func getRegistryKeyOnlyInDebug() {

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

    static var xApiKey: String {
        get throws {
            return try value(for: Settings.Key.xApiKey)
        }
    }

    static var firebaseKey: String {
        get throws {
            return try ConditionalCompilationSettingsProvider.getValue(
                Settings.Key.firebaseKey.rawValue)
        }
    }

    static var registyApiKey: String {
        get throws {
            return try SchemeEnvironmentVariableProvider.getValue(
                Settings.Key.registryApiKey.rawValue)
        }
    }

    static var remoteConfigKey: String {
        get throws {
            return try BuildScriptConfigsProvider.getValue(
                Settings.Key.remoteConfiKey.rawValue)
        }
    }

}

func showActiveCompilationConditions() {
    #if FEATURE_A
        print("Feature A")
    #else
        print("Not Feature A")
    #endif

    #if FEATURE_B
        print("Feature B")
    #else
        print("Not Feature B")
    #endif
}
