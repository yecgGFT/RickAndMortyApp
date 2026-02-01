//
//  CharactersDetailView.swift
//  rickandmorty-ios
//
//  Created by Chang Chen, Ya-We on 16/1/26.
//


import SwiftUI

struct CharactersDetailView: View {
    @StateObject private var vm: CharactersDetailViewModel
    
    init(id: Int) {
        _vm = StateObject(wrappedValue: CharactersDetailViewModel(id: id))
    }
    
    var body: some View {

        ScrollView {
            switch vm.viewState {
            case .finish:
                if let character = vm.character {
                    ComponentDetailView(character: character)
                } else {
                    MessageView(model: .init(message: L10nCatalog.dataNoFound.string, fgColor: .gray))
                }
            case .loading:
                ProgressView(L10nCatalog.loading.string)
            case .error(let error):
                MessageView(model: .init(message: "Error: \(error.localizedDescription)", fgColor: .gray))
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(.details)
        .task {
            await vm.load()
        }
       
    }
}

#Preview("Success") {
    CharactersDetailView(id: 1)
}
