//
//  NavigationProtocol.swift
//  rickandmorty-ios
//
//  Created by Chang Chen, Ya-We on 29/1/26.
//

import SwiftUI
import Observation

protocol ViewSpec: Hashable {}

@MainActor
protocol NavigationProtocol: AnyObject {
    associatedtype Route: ViewSpec
    var path: [Route] { get set }

    func push(_ route: Route)
    func pop()
    func reset()
}


@MainActor
extension NavigationProtocol {
    func push(_ route: Route) { path.append(route) }
    func pop() { _ = path.popLast() }
    func reset() { path.removeAll() }
}
