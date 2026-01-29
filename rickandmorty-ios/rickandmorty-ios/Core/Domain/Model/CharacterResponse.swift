//
//  CharacterResponse.swift
//  rickandmorty-ios
//
//  Created by Chang Chen, Ya-We on 16/1/26.
//

import Foundation


enum StatusScope: String, CaseIterable, Hashable {
    case all = ""        // sin filtro
    case alive = "alive"
    case dead = "dead"
    case unknown = "unknown"

    var title: String {
        switch self {
        case .all: return "Todos"
        case .alive: return "Alive"
        case .dead: return "Dead"
        case .unknown: return "Unknown"
        }
    }

    var apiValue: String? {
        self == .all ? nil : self.rawValue
    }
}



enum SpeciesScope: String, CaseIterable, Hashable {
    case all = ""                 // sin filtro
    case human = "human"
    case alien = "alien"
    case humanoid = "humanoid"
    case robot = "robot"
    case animal = "animal"
    case cronenberg = "cronenberg"
    case disease = "disease"
    case mythological = "mythological creature"
    case unknown = "unknown"

    var title: String {
        switch self {
        case .all:         return "Todas"
        case .human:       return "Human"
        case .alien:       return "Alien"
        case .humanoid:    return "Humanoid"
        case .robot:       return "Robot"
        case .animal:      return "Animal"
        case .cronenberg:  return "Cronenberg"
        case .disease:     return "Disease"
        case .mythological:return "Mythological"
        case .unknown:     return "Unknown"
        }
    }

    var apiValue: String? { self == .all ? nil : self.rawValue }
}

struct CharactersPage: Decodable {
    struct Info: Decodable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }

    let info: Info
    let results: [Character]
}


struct Character: Identifiable, Decodable {
    
    let id: Int
    let name: String
    let status: String
    let species: String
    let image: String
    let gender: String
    let origin: CharacterLocationRef
    let location: CharacterLocationRef
}



struct CharacterLocationRef: Codable, Equatable {
    let name: String
    let url: String
}
