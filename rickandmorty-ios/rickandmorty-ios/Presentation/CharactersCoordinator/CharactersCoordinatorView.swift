//
//  CharactersCoordinatorView.swift
//  rickandmorty-ios
//
//  Created by Chang Chen, Ya-We on 16/1/26.
//

import SwiftUI


// MARK: - Root con NavigationStack
struct CharactersCoordinatorView: View {
    @State private var nav = CharactersCoordinator()   // @Observable
    private let router = CharactersRouter()

    var body: some View {
        NavigationStack(path: $nav.path) {
            router.view(for: .home)
                .navigationDestination(for: CharactersRoute.self) { route in
                    router.view(for: route)
                }
        }
        .environment(nav) // Inyección por tipo (Observation)
    }
}
