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
            Log.log(.error, .viewModel, "Error loading character detail: \(error)")
            viewState = .error(error)
        }
    }
}
