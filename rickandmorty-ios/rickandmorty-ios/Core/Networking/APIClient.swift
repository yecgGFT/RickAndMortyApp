//
//  APIClient.swift
//  rickandmorty-ios
//
//  Created by Chang Chen, Ya-We on 20/1/26.
//

import Foundation
import Combine


protocol APIClient {
    func send<T: APIRequest>(_ request: T) async throws -> T.Response
    func sendPublisher<T: APIRequest>(_ request: T) -> AnyPublisher<T.Response, Error>
}
