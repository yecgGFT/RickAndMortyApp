//
//  CharactersCoordinator.swift
//  rickandmorty-ios
//
//  Created by Chang Chen, Ya-We on 28/1/26.
//

import SwiftUI
import Observation

// MARK: - Rutas de Characters
public enum CharactersRoute: ViewSpec {
    case home
    case characterDetail(id: Int)
}

// MARK: - Coordinator (Observation, iOS 17+)
@MainActor
@Observable
final class CharactersCoordinator: NavigationProtocol {
    typealias Route = CharactersRoute
    var path: [CharactersRoute] = []
    init() {}
    // push/pop/reset vienen de la extensión del protocolo.
}

@MainActor
public struct CharactersRouter: @MainActor AppRoutingProtocol {
    public init() {}
    @ViewBuilder
    public func view(for route: CharactersRoute) -> some View {
        switch route {
        case .home:
            CharactersListView()
        case .characterDetail(let id):
            CharactersDetailView(id: id)
        }
    }
}
