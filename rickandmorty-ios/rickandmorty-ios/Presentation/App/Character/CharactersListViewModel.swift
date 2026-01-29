//
//  CharactersListViewModel.swift
//  rickandmorty-ios
//
//  Created by Chang Chen, Ya-We on 16/1/26.
//


import Foundation
import Combine

class CharactersListViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var reachedEnd = false
    @Published var searchText: String = "" {
          didSet { debounceSearch() }
      }
    
    @Published var statusScope: StatusScope = .all {
            didSet { Task { await refresh() } }
    }
    
    @Published var speciesScope: SpeciesScope = .all {
         didSet { Task { await refresh() } }
     }



    private var currentPage = 1
    private var totalPages = Int.max
    private var searchTask: Task<Void, Never>?
    private let slepNanoSeconds: UInt64 = 300_000_000 // 0.3s debounce
    
    let characterService: CharactersDataService

    init(apiClient: APIClient =  SessionAPIClient()) {
        characterService = CharactersDataService(apiClient)
    }
    
    
    // MARK: - Debounce para evitar llamadas por cada tecla
    private func debounceSearch() {
        searchTask?.cancel()
        searchTask = Task {
            try? await Task.sleep(nanoseconds: slepNanoSeconds)
            await refresh()
        }
    }


    func loadNextPage() async {
        guard !isLoading, currentPage <= totalPages else { return }

        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            
            let response = try await characterService.fetchCharacters(page: currentPage, name: searchText, status: statusScope.apiValue, species: speciesScope.apiValue)
            characters.append(contentsOf: response.results)

            totalPages = response.info.pages
            currentPage += 1

            if currentPage > totalPages {
                reachedEnd = true
            }
        } catch {
            print("Error loading page:", error)
            errorMessage = "Error loading page: \(error.localizedDescription)"
        }
    }

    func refresh() async {
        currentPage = 1
        totalPages = Int.max
        characters.removeAll()
        reachedEnd = false
        await loadNextPage()
    }
    
    func isFirstPage() -> Bool {
        return currentPage == 1
    }
}
