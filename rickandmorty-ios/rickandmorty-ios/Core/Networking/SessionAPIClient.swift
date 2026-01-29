//
//  SessionAPIClient.swift
//  rickandmorty-ios
//
//  Created by Chang Chen, Ya-We on 23/1/26.
//
import Foundation
import Combine


final class SessionAPIClient: APIClient {
    
    private let session: URLSession
    private let baseURL: URL?
    
    init(session: URLSession = .shared, baseURL: URL? = BuildConfiguration.shared.getBaseURL()) {
        self.session = session
        self.baseURL = baseURL
    }
    
    private func buildRequest<T: APIRequest>(for request: T) async throws -> URLRequest {
        guard
            let url = URL(string: request.path, relativeTo: baseURL),
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            else {
            throw APIError.invalidURL
        }
        
        let customQueryItems = request.generateQueryItems()
        components.queryItems = customQueryItems.isEmpty ? nil : customQueryItems

        guard let finalURL = components.url else { fatalError("Bad URLComponents construction") }
        
        var urlRequest = URLRequest(url: finalURL)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
    
        urlRequest.addValue(ContentType.applicationJSON.contentTpeValue, forHTTPHeaderField: "Content-Type")
        
        return URLRequest(url: finalURL)
    }
    
    
    func send<T: APIRequest>(_ request: T) async throws -> T.Response {
        
        let urlRequest = try await buildRequest(for: request)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard let http = response as? HTTPURLResponse,
            200..<300 ~= http.statusCode else {
            throw APIError.badStatus((response as? HTTPURLResponse)?.statusCode ?? -1)
        }
        
        do {
            return try JSONDecoder().decode(T.Response.self, from: data)
        } catch {
            throw APIError.decoding(error)
        }
    }

    
    // MARK: - COMBINE
    func sendPublisher<T: APIRequest>(_ request: T) -> AnyPublisher<T.Response, Error> {
        
        
        let requestPublisher = Future<URLRequest, Error> { promise in
                Task {
                    do {
                        let urlRequest = try await self.buildRequest(for: request)
                        promise(.success(urlRequest))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }

        
        return requestPublisher
            .flatMap { urlRequest in
                URLSession.shared.dataTaskPublisher(for: urlRequest)
                    .mapError { $0 as Error }
                    .map(\.data)
                    .decode(type: T.Response.self, decoder: JSONDecoder())
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()

    }
       

}
