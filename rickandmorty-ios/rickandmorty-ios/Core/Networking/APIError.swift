//
//  APIError.swift
//  rickandmorty-ios
//
//  Created by Chang Chen, Ya-We on 21/1/26.
//

import Foundation


enum APIError: Error, LocalizedError {
    case invalidURL
    case undefinedError
    case badStatus(Int)
    case decoding(Error)
    case transport(Error)
    case notfound404
    case invalidResponse

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .badStatus(let code): return "Unexpected status code: \(code)"
        case .decoding(let err): return "Decoding error: \(err.localizedDescription)"
        case .transport(let err): return "Network error: \(err.localizedDescription)"
        case .undefinedError: return "Undefined Error"
        case .notfound404: return "Not Found"
        case .invalidResponse: return "Invalid Response"
        }
    }
}
