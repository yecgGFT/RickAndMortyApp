//
//  APIRequest.swift
//  rickandmorty-ios
//
//  Created by Chang Chen, Ya-We on 20/1/26.
//


import Foundation

enum APIResource {
    case characterList
    case character(id: String)
    case episodeList
    case episode(id: String)
    case locationList
    case location(id: String)
    
    func getResourcePath() -> String  {
        switch self {
        case .characterList:
            return "/api/character"
        case let .character(id):
            return "/api/character/\(id)"
        case .episodeList:
            return "/api/episode"
        case let .episode(id):
            return "/api/episode/\(id)"
        case .locationList:
            return "/api/location"
        case let .location(id):
            return "/api/location/\(id)"
        }
    }
}

protocol APIRequest {
    associatedtype Response: Decodable
    
    var path: String { get }
    var method: HTTPMethod { get }
    var contentType: ContentType? { get }
    var headers: [String: String] { get }
    var queryItems: [URLQueryItem] { get }
    var body: Data? { get }
    
    func generateQueryItems() -> [URLQueryItem]
}

extension APIRequest {
    var method: HTTPMethod { .GET }
    var contentType: ContentType? { .applicationJSON }
    var headers: [String: String] { [:] }
    var queryItems: [URLQueryItem] { [] }
    var body: Data? { nil }
}


enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}


enum ContentType {
    case applicationJSON
    case multipartForm(boundary: String)
    case applicationXwwwformurlencoded
    
    var contentTpeValue: String {
        switch self {
        case .applicationJSON:
            return "application/json"
        case .multipartForm(let boundary):
            return "multipart/form-data; boundary=\(boundary)"
        case .applicationXwwwformurlencoded:
            return "application/x-www-form-urlencoded"
        }
    }
}
