//
//  APIError.swift
//  rickandmorty-ios
//
//  Created by Chang Chen, Ya-We on 21/1/26.
//

import Foundation


enum APIError: Error, LocalizedError {
    case invalidURL
    case badStatus(Int)
    case decoding(Error)
    case transport(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .badStatus(let code): return "Unexpected status code: \(code)"
        case .decoding(let err): return "Decoding error: \(err.localizedDescription)"
        case .transport(let err): return "Network error: \(err.localizedDescription)"
        }
    }
}
