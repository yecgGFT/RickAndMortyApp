//
//  Translator.swift
//  rickandmorty-ios
//
//  Created by Chang Chen, Ya-We on 30/1/26.
//

import SwiftUI

struct Translator {
    let key: String
    let arguments: [CVarArg]
    
    init(key: String, arguments: [CVarArg] = []) {
        self.key = key
        self.arguments = arguments
    }
    
    var string: String {
        if NSLocalizedString(key, comment: "") == key {
            Log.log(.error, .l10n, "ERROR >>> Translator >>> NOT FOUND \(key)")
            return key
        }
        
        let localized = NSLocalizedString(key, comment: ".empty")
        return arguments.isEmpty ? localized : String(format: localized, arguments: arguments)
    }
}

struct L10nCatalog {
    
    static let charactersTitle = Translator(key: "characters_title")
    static let searchCharacters = Translator(key: "search_characters")
    static let noMoreCharacters = Translator(key: "no_more_characters")
    static let dataNoFound = Translator(key: "data_nofound")
    static let loading = Translator(key: "loading")
    static let retry = Translator(key: "retry")
    static let status = Translator(key: "status")
    static let species = Translator(key: "species")
    static let gender = Translator(key: "gender")
    static let origin = Translator(key: "origin")
    static let lastLocation = Translator(key: "lastLocation")
    
}

