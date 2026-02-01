//
//  ComponentDetailView.swift
//  rickandmorty-ios
//
//  Created by Chang Chen, Ya-We on 29/1/26.
//

import SwiftUI

struct ComponentDetailView: View {
    let character: Character
    
    var body: some View {
        VStack(spacing: Tokens.Spacing.spacingsm) {
            
            AsyncImage(url: URL(string: character.image)) { image in
                image.resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(maxWidth: .infinity)
            
            Text(character.name)
                .font(.largeTitle)
                .bold()
            
            VStack(alignment: .leading, spacing: Tokens.Spacing.spacingxxs) {
                ComponentDetailRowView(title: L10nCatalog.status.string, value: character.status.rawValue)
                ComponentDetailRowView(title: L10nCatalog.species.string, value: character.species)
                ComponentDetailRowView(title: L10nCatalog.gender.string, value: character.gender.rawValue)
                ComponentDetailRowView(title: L10nCatalog.origin.string, value: character.origin.name)
                ComponentDetailRowView(title: L10nCatalog.lastLocation.string, value: character.location.name)
            }
            .padding()
        }
    }
}
