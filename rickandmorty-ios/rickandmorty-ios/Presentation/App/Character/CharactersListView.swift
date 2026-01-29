//
//  CharactersListView.swift
//  rickandmorty-ios
//
//  Created by Chang Chen, Ya-We on 16/1/26.
//


import SwiftUI


struct ErrorMessageWithRetry: View {
    let errorMessage: String
    
    var body: some View {
            
        Text(errorMessage)
            .padding(.vertical)
        Label("Reload", systemImage: "arrow.counterclockwise")
        
    }
}


struct CharactersListView: View {
    @StateObject private var vm = CharactersListViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 12) {
                    
                    if let errorMessage = vm.errorMessage, vm.isFirstPage() {
                        MessageView(message: errorMessage,color: .gray)
                    } else {
                        ListViews()
                        if vm.isLoading {
                            ProgressView()
                                .padding()
                        }
                        
                        if let errorMessage = vm.errorMessage {
                            MessageView(message: errorMessage, showRetry: true, color: .gray)
                            .onTapGesture {
                                Task { await vm.loadNextPage() }
                            }
                            
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Characters")
            .searchable(text: $vm.searchText, prompt: "Buscar personajes…")
            .searchScopes($vm.statusScope) {
                           Text(StatusScope.all.title).tag(StatusScope.all)
                           Text(StatusScope.alive.title).tag(StatusScope.alive)
                           Text(StatusScope.dead.title).tag(StatusScope.dead)
                           Text(StatusScope.unknown.title).tag(StatusScope.unknown)
                       }
            
            .toolbar {
                filterSpeciesToolbarItem()
            }
            .task {
                await vm.loadNextPage()
            }
            .refreshable {
                await vm.refresh()
            }
        }
    }
}

extension CharactersListView {
    func filterSpeciesToolbarItem() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Menu {
                Picker("Species", selection: $vm.speciesScope) {
                    ForEach(SpeciesScope.allCases, id: \.self) { scope in
                        Text(scope.title).tag(scope)
                    }
                }
            } label: {
                Label("Filters", systemImage: "line.3.horizontal.decrease.circle")
            }
        }
    }
    
    @ViewBuilder
    func ListViews() -> some View {
        ForEach(vm.characters) { character in
            NavigationLink(destination: CharactersDetailView(id: character.id)) {
                CharacterListRow(character: character)
                    .onAppear {
                        if character.id == vm.characters.last?.id {
                            Task { await vm.loadNextPage() }
                        }
                    }
            }
            .buttonStyle(.plain)
        }
        
        if vm.reachedEnd {
            MessageView(message: "No more characters", color: .gray)
        }
    }
}



struct CharacterListRow: View {
    let character: Character

    var body: some View {
        VStack {
            HStack(spacing: 16) {
                AsyncImage(url: URL(string: character.image)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text(character.name)
                        .font(.headline)
                    Text(character.species)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.vertical, 6)
        }
    }
}

