//
//  ViewStateModel.swift
//  rickandmorty-ios
//
//  Created by Chang Chen, Ya-We on 20/1/26.
//

enum ViewStateModel {
    case finish
    case loading
    case error(Error)
}

extension ViewStateModel: Equatable {
    static func ==(lhs: ViewStateModel, rhs: ViewStateModel) -> Bool {
        switch (lhs, rhs) {
        case (.finish, .finish), (.loading, .loading): return true
        case (.error, .error): return true
        default:
            return false
        }
    }
}
