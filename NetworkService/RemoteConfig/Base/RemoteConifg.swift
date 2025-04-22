//
//  RemoteConifg.swift
//  NetworkService
//
//  Created by Jerry Li on 2025/4/22.
//

public class RemoteConifg {

    public init() {

    }

    public func fetchRemoteConfigs() -> [String: String] {
        return ["DASHBORARD_PROMPT_MESSAGE": "Welcome!"]
    }
}
