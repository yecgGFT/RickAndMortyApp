//
//  BuildConfiguration.swift
//  rickandmorty-ios
//
//  Created by Chang Chen, Ya-We on 23/1/26.
//

import Foundation

class BuildConfiguration {
    static let shared = BuildConfiguration()
    
    let clientHost: String
    
    init() {
        clientHost = "https://rickandmortyapi.com/"
    }
    
    
    func getBaseURL() -> URL? {
        return URL(string: clientHost)
    }
    
    
}
