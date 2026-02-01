//
//  Character.swift
//  rickandmorty-ios
//
//  Created by Chang Chen, Ya-We on 16/1/26.
//

import Foundation

enum StatusScope: String, CaseIterable, Hashable {
    case all = "" 
    case alive = "Alive"
    case dead = "Dead"
    case unknown
    
    var apiValue: String? {
        self == .all ? nil : self.rawValue
    }
}



enum SpeciesScope: String, CaseIterable, Hashable {
    case all = ""    
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

struct CharactersPage {
    struct Info {
        let count: Int
        let pages: Int
    }

    let info: Info
    let results: [Character]
}


struct Character: Identifiable {

    enum Status: String, CaseIterable {
        case alive = "Alive"
        case dead  = "Dead"
        case unknown = "unknown"

        
        init(from rawValue: String) {
            switch rawValue.lowercased() {
            case "alive":
                self = .alive
            case "dead":
                self = .dead
            default:
                self = .unknown
            }
        }
    }
    
    enum Gender: String, CaseIterable {
        case male = "Male"
        case female = "Female"
        case genderless = "Genderless"
        case unknown = "unknown"
        
        init(from rawValue: String) {
            switch rawValue.lowercased() {
            case "female":
                self = .female
            case "fale":
                self = .male
            case "genderless":
                self = .genderless
            default:
                self = .unknown
            }
        }
    }
    
    let id: Int
    let name: String
    let status: Status
    let species: String
    let image: String
    let gender: Gender
    let origin: CharacterLocationRef
    let location: CharacterLocationRef
}

struct CharacterLocationRef {
    let name: String
    let url: String
}
