//
//  CharactersListViewModelTests.swift
//  rickandmorty-ios
//
//  Created by Chang Chen, Ya-We on 27/1/26.
//


import XCTest
@testable import rickandmorty_ios

@MainActor
final class CharactersListViewModelTests: XCTestCase {


    // MARK: - Test: carga de primera página OK
    func testLoadNextPageSuccess() async  {
            
        let mockData = HelperMockData.getMockResponse(.charactersList)
        let mock = APIClientMock(mockData: [APIResource.characterList.getResourcePath() : mockData])
        let vm = CharactersListViewModel(apiClient: mock)

        XCTAssertTrue(vm.isFirstPage())
        XCTAssertEqual(vm.characters.count, 0)
        XCTAssertNil(vm.errorMessage)
        XCTAssertFalse(vm.isLoading)

        await vm.loadNextPage()
        
        XCTAssertEqual(vm.characters.count, 20)
        XCTAssertNil(vm.errorMessage)
        XCTAssertFalse(vm.reachedEnd)
        XCTAssertFalse(vm.isFirstPage())
    }

    // MARK: - Test: paginación y reachedEnd
    func testPaginationReachedEndTrueonlastpage() async  {

        let mockData = HelperMockData.getMockResponse(.charactersList)
        let mock = APIClientMock(mockData: [APIResource.characterList.getResourcePath() : mockData])
        let vm = CharactersListViewModel(apiClient: mock)

        await vm.loadNextPage() // page 1
        
        XCTAssertEqual(vm.characters.count, 20)
        XCTAssertFalse(vm.reachedEnd)

        await vm.loadNextPage() // page 2 (última)
        XCTAssertEqual(vm.characters.count, 40)
        // Al haber superado totalPages, reachedEnd debe ser true
        XCTAssertTrue(vm.reachedEnd)
    }

    // MARK: - Test: manejo de error
    func testLoadNextPageErrorSetsErrorMessage() async {
        let mockData = MockResponse(error: MockError.testError)
        let mock = APIClientMock(mockData: [APIResource.characterList.getResourcePath() : mockData])
        let vm = CharactersListViewModel(apiClient: mock)

        await vm.loadNextPage()

        XCTAssertEqual(vm.characters.count, 0)
        XCTAssertNotNil(vm.errorMessage)
        XCTAssertFalse(vm.isLoading)
        XCTAssertFalse(vm.reachedEnd)
    }
    

    // MARK: - Test: refresh resetea y carga primera página
    func testRefreshResetsStateAndLoadsFirstPage() async throws {
        
        let mockData = HelperMockData.getMockResponse(.charactersList)
        let mock = APIClientMock(mockData: [APIResource.characterList.getResourcePath() : mockData])
        let vm = CharactersListViewModel(apiClient: mock)

        await vm.loadNextPage()
        await vm.loadNextPage()
        XCTAssertEqual(vm.characters.count, 40)

        await vm.refresh()
        
        // refresh debe vaciar y cargar page 1
        XCTAssertGreaterThan(vm.characters.count, 0)
        XCTAssertFalse(vm.reachedEnd)
        XCTAssertNil(vm.errorMessage)
        
        // No podemos leer currentPage directamente, pero isFirstPage debe ser false tras cargar (porque incrementa después de cargar)
        XCTAssertFalse(vm.isFirstPage())
    }

}
