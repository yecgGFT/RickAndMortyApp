//
//  CharactersDataService.swift
//  rickandmorty-ios
//
//  Created by Chang Chen, Ya-We on 16/1/26.
//
import Foundation

struct CharactersPageRequest: APIRequest {

    typealias Response = CharactersPageDTO

    var path: String = APIResource.getResourcePath(.characterList)()
    var method: HTTPMethod = .GET
    var body: Data?
    let page: Int
    let name: String?
    let status: String?
    let species: String?

    init(page: Int, name: String?, status: String?, species: String?) {
        self.page = page
        self.name = name
        self.status = status
        self.species = species
    }

    func generateQueryItems() -> [URLQueryItem] {

        var query: [URLQueryItem] = [
            URLQueryItem(name: "page", value: "\(page)")
        ]

        if let name, !name.isEmpty {
            query.append(URLQueryItem(name: "name", value: name))

        }

        if let status, !status.isEmpty {
            query.append(URLQueryItem(name: "status", value: status))
        }

        if let species, !species.isEmpty {
            query.append(URLQueryItem(name: "species", value: species))
        }

        return query

    }

}

struct CharacterDetailRequest: APIRequest {

    typealias Response = CharacterDTO

    var path: String = ""
    var body: Data?

    func generateQueryItems() -> [URLQueryItem] {
        return []
    }

    init(id: Int) {
        self.path = APIResource.getResourcePath(.character(id: String(id)))()
    }

}

class CharactersDataService {
    let apiClient: APIClient

    init(_ client: APIClient = SessionAPIClient()) {
        apiClient = client
    }

    func fetchCharacters(
        page: Int,
        name: String?,
        status: String?,
        species: String?
    ) async throws -> CharactersPage {
        let request = CharactersPageRequest(
            page: page,
            name: name,
            status: status,
            species: species
        )
        return try await apiClient.send(request).transform()
    }

    func fetchCharacterDetail(id: Int) async throws -> Character {
        let request = CharacterDetailRequest(id: id)
        return try await apiClient.send(request).transform()
    }
}
