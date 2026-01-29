//
//  CharactersDetailViewModelTests.swift
//  rickandmorty-iosTests
//
//  Created by Chang Chen, Ya-We on 21/1/26.
//

import XCTest
@testable import rickandmorty_ios

@MainActor
final class CharactersDetailViewModelTests: XCTestCase {

    // MARK: - Estado inicial
    func testInitialStateIsloadingAndNilCharacter() async {
        
        let mockData = HelperMockData.getMockResponse(.charactersDetail)
        let mockClient = APIClientMock(mockData: [APIResource.character(id: "1").getResourcePath() : mockData])
        let vm = CharactersDetailViewModel(apiClient: mockClient, id: 1)

        XCTAssertNil(vm.character)
        XCTAssertEqual(vm.viewState, ViewStateModel.loading)
    }

    // MARK: - load() éxito: setea character y viewState .finish
    func testLoadSuccessSetsCharacterAndFinish() async {
        let mockData = HelperMockData.getMockResponse(.charactersDetail)
        let mockClient = APIClientMock(mockData: [APIResource.character(id: "1").getResourcePath() : mockData])
        let vm = CharactersDetailViewModel(apiClient: mockClient, id: 1)
        
        let expectedCharacters =  try? JSONDecoder().decode(Character.self, from: mockData.data)

        // Estado inicial
        XCTAssertEqual(vm.viewState, ViewStateModel.loading)
        XCTAssertNil(vm.character)

        // Act
        await vm.load()

        guard let vmCharacter = vm.character, let expectedCharacters = expectedCharacters else {
            return
        }
        
        XCTAssertEqual(vmCharacter.id, expectedCharacters.id)
        XCTAssertEqual(vmCharacter.name, expectedCharacters.name)
        XCTAssertEqual(vm.viewState, ViewStateModel.finish)
    }

    // MARK: - load() error: deja character en nil y viewState .error
    func testLoadFailureSetsErrorStateAndKeepsCharacterNil() async {
        let mockData = MockResponse(error: MockError.testError)
        let mockClient = APIClientMock(mockData: [APIResource.character(id: "1").getResourcePath() : mockData])
        let vm = CharactersDetailViewModel(apiClient: mockClient, id: 1)

        await vm.load()

        // Assert
        XCTAssertNil(vm.character)
        XCTAssertEqual(vm.viewState, ViewStateModel.error(MockError.testError))
    }
}

