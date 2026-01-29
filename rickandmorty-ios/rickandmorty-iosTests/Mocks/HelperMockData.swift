//
//  HelperMockData.swift
//  rickandmorty-ios
//
//  Created by Chang Chen, Ya-We on 27/1/26.
//

import Foundation

@testable import rickandmorty_ios

enum JsonFile: String {
    case charactersList = "charactersList"
    case charactersDetail = "charactersDetail"
}

class HelperMockData {
  
    private static func loadData(resourceName: String) throws -> Data? {
        
        let bundle = Bundle(for: HelperMockData.self)
        
        guard let filePath = bundle.url(forResource: resourceName, withExtension: "json") else {
            print("Error: File '\(resourceName).json' not found in bundle \(bundle.bundlePath)")
            throw MockError.jsonNoFound
        }
        
        do {
            let contents = try String(contentsOf: filePath, encoding: .utf8)
            print(contents)
            
            if let data = contents.data(using: .utf8) {
                return data
            } else {
                print("Error Mapping")
                throw MockError.errorMapping
            }
        } catch {
            print("Error: \(error)")
            throw error
        }
    }

    
    static func getMockResponse(_ file: JsonFile) -> MockResponse {
        do {
            guard let data = try loadData(resourceName: file.rawValue) else {
                return MockResponse(error: MockError.testError)
            }
            return MockResponse(data: data)
        } catch {
            return MockResponse(error: error)
        }
    }
}
