//
//  BuildConfiguration.swift
//  rickandmorty-ios
//
//  Created by Chang Chen, Ya-We on 23/1/26.
//

import Foundation

enum Environments: String {
    case debug = "Debug"
    case release = "Release"
}

final class BuildConfiguration {
    static let shared = BuildConfiguration()

    let clientHost: String
    let environment: Environments

    init() {
        let currentConfiguration =
            Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String
            ?? ""

        environment = Environments(rawValue: currentConfiguration) ?? .debug

        switch environment {
        case .debug:
            clientHost = "https://rickandmortyapi.com/"
        case .release:
            clientHost = "https://rickandmortyapi.com/"
        }
    }

    func getBaseURL() -> URL? {
        return URL(string: clientHost)
    }
    
    func showLog() -> Bool {
       return environment == .debug
    }

}
