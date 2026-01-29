//
//  APIClientMock.swift
//  rickandmorty-ios
//
//  Created by Chang Chen, Ya-We on 27/1/26.
//

import Combine
import Foundation

@testable import rickandmorty_ios

enum MockError: Error {
    case testError
    case noMatchingMock
    case jsonNoFound
    case errorMapping
}

struct MockResponse {
    
    //MARK: - Properties
    var data: Data
    var statusCode: Int
    var match: String?
    var error: Error?
    
    //MARK: - Inits
    init(data: Data = Data(), statusCode: Int = 200, match: String? = nil, error: Error? = nil) {
        self.data = data
        self.statusCode = statusCode
        self.match = match
        self.error = error
    }
    
    //MARK: - Methods
    func response<T>(for request: T) -> HTTPURLResponse where T: APIRequest {
        let url = URL(string: request.path)!
        return HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
    }
    
    func data<T: APIRequest>(for request: T) -> Data? {
        if let _ = error {
            return nil
        }
        guard let match = match, let body = request.body, let json = try? JSONSerialization.jsonObject(with: body, options: .fragmentsAllowed) as? [String: Any?] else {
            return data
        }
        
        // try to find the value with match
        let value = json.values.map(String.init(describing:))
        if value.contains(where: { $0.contains(match) }) {
            return data
        } else {
            return nil
        }
    }
}

class APIClientMock: APIClient {
    
    
    var mockData: [String: MockResponse]
    
    init(mockData: [String : MockResponse]) {
        self.mockData = mockData
    }
    
    func send<T>(_ request: T) async throws -> T.Response where T : APIRequest {
        
        guard let mockedCase = mockData[request.path] else {
            throw MockError.testError
        }

        if let error = mockedCase.error {
            throw error
        }
        guard let data = mockedCase.data(for: request) else {
            throw MockError.testError
        }

        return try JSONDecoder().decode(T.Response.self, from: data)

    }
    
    func sendPublisher<T>(_ request: T) -> AnyPublisher<T.Response, Error> where T: APIRequest {

        guard let mockedCase = mockData[request.path] else {
            return Fail(error: MockError.testError).eraseToAnyPublisher()
        }

            
        if let error = mockedCase.error {
            return Fail(error: error).eraseToAnyPublisher()
        }
            
        guard let data = mockedCase.data(for: request) else {
            return Fail(error: MockError.noMatchingMock)
                .eraseToAnyPublisher()
        }
        
        do {
            let decoded = try JSONDecoder().decode(T.Response.self, from: data)
            return Just(decoded)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: APIError.decoding(error))
                        .eraseToAnyPublisher()
        }

    }
    
}
