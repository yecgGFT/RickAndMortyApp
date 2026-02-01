//
//  CharacterDTO.swift
//  rickandmorty-ios
//
//  Created by Chang Chen, Ya-We on 16/1/26.
//

struct CharactersPageDTO: Decodable {
    struct InfoDTO: Decodable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }

    let info: InfoDTO
    let results: [CharacterDTO]

}


struct CharacterDTO: Decodable {
    
    let id: Int
    let name: String
    let status: String
    let species: String
    let image: String
    let gender: String
    let origin: CharacterLocationRefDTO
    let location: CharacterLocationRefDTO
}


struct CharacterLocationRefDTO: Decodable  {
    let name: String
    let url: String
}
