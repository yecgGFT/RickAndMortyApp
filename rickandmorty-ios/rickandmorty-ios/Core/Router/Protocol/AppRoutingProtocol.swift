//
//  AppRoutingProtocol.swift
//  rickandmorty-ios
//
//  Created by Chang Chen, Ya-We on 1/2/26.
//

import SwiftUI

@MainActor
public protocol AppRoutingProtocol {
    associatedtype R: Hashable
    associatedtype AppView: View
    @ViewBuilder func view(for route: R) -> AppView
}
