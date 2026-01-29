//
//  CharactersDetailViewModel.swift
//  rickandmorty-ios
//
//  Created by Chang Chen, Ya-We on 20/1/26.
//

import Foundation
import Combine
import SwiftUI

final class CharactersDetailViewModel: ObservableObject {
    
    @Published var character: Character?
    @Published var viewState: ViewStateModel = .loading

    private let characterService: CharactersDataService
    private let characterId: Int

    init(apiClient: APIClient =  SessionAPIClient(), id: Int) {
        self.characterService = CharactersDataService(apiClient)
        self.characterId = id
    }

    
    func load() async {
        do {
            self.character = try await characterService.fetchCharacterDetail(id: characterId)
            self.viewState = .finish
        } catch {
            print("Error loading character detail:", error)
            viewState = .error(error)
        }
    }
}

extension CharactersDetailViewModel {
    static func previewMock() -> CharactersDetailViewModel {
        let vm = CharactersDetailViewModel(id: 0)

        vm.character = Character(
            id: 999,
            name: "Preview Morty",
            status: "Alive",
            species: "Human",
            image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
            gender: "Male",
            origin: CharacterLocationRef(name: "Earth (C-137)",
                                         url: "https://rickandmortyapi.com/api/location/1"),
            location: CharacterLocationRef(name: "Citadel of Ricks",
                                           url: "https://rickandmortyapi.com/api/location/3")
        )

        return vm
    }
}
