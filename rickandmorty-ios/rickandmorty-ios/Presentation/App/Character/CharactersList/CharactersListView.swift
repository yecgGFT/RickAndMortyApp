//
//  CharactersListView.swift
//  rickandmorty-ios
//
//  Created by Chang Chen, Ya-We on 16/1/26.
//
import SwiftUI

struct CharactersListView: View {
    @Environment(CharactersCoordinator.self) private var nav
    @StateObject private var vm = CharactersListViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(
                    alignment: .leading,
                    spacing: Tokens.Spacing.spacingxs
                ) {
                    if let errorMessage = vm.errorMessage, vm.isFirstPage() {
                        MessageView(
                            model: .init(message: errorMessage, fgColor: .gray)
                        )
                    } else {
                        ListViews()
                        if vm.isLoading {
                            ProgressView()
                                .padding()
                        }

                        if let errorMessage = vm.errorMessage {
                            MessageView(
                                model: .init(
                                    message: errorMessage,
                                    retryText: L10nCatalog.retry.string,
                                    fgColor: .gray
                                )
                            )
                            .onTapGesture {
                                Task {
                                    await vm.loadNextPage()
                                }
                            }

                        }
                    }
                }
                .padding()
            }
            .navigationTitle(.charactersTitle)
            .toolbar {
                filterSpeciesToolbarItem()
            }
            .searchable(
                text: $vm.searchText,
                prompt: L10nCatalog.searchCharacters.string
            )
            .searchScopes($vm.statusScope) {
                Text(.all).tag(StatusScope.all)
                Text(StatusScope.alive.rawValue).tag(StatusScope.alive)
                Text(StatusScope.dead.rawValue).tag(StatusScope.dead)
                Text(StatusScope.unknown.rawValue).tag(StatusScope.unknown)
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
                Picker(L10nCatalog.species.string, selection: $vm.speciesScope) {
                    ForEach(SpeciesScope.allCases, id: \.self) { scope in
                        Text(scope.title).tag(scope)
                    }
                }
            } label: {
                HStack {
                    Tokens.Icons.filter
                }
                .padding(.horizontal, Tokens.Spacing.spacingxxxs)

            }
        }
    }

    @ViewBuilder
    func ListViews() -> some View {
        ForEach(vm.characters) { character in
            NavigationLink(destination: CharactersDetailView(id: character.id))
            {
                CharacterListRow(character: character)
                    .onAppear {
                        if character.id == vm.characters.last?.id {
                            Task { await vm.loadNextPage() }
                        }
                    }
            }
            .buttonStyle(.plain)
        }

        if vm.reachedEnd && vm.searchText.isEmpty {
            MessageView(
                model: .init(
                    message: L10nCatalog.noMoreCharacters.string,
                    fgColor: .gray
                )
            )
        }
    }
}
