//
//  Untitled.swift
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
    
    // Preview initializer
    init(previewVM: CharactersDetailViewModel) {
        _vm = StateObject(wrappedValue: previewVM)
    }
    
    var body: some View {

        ScrollView {
            switch vm.viewState {
            case .finish:
                if let character = vm.character {
                    ComponentDetailView(character: character)
                } else {
                    MessageView(message: "No data found", color: .gray)
                }
            case .loading:
                ProgressView("Loading…")
            case .error(let error):
                MessageView(message: "Error: \(error.localizedDescription)", color: .gray)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await vm.load()
        }
    }
}

#Preview {
    CharactersDetailView(previewVM: .previewMock())
}
