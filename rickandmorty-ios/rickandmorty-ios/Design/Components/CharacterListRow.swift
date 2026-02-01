//
//  CharacterListRow.swift
//  rickandmorty-ios
//
//  Created by Chang Chen, Ya-We on 29/1/26.
//

import SwiftUI

struct CharacterListRow: View {
    let character: Character

    var body: some View {
        VStack {
            HStack(spacing: Tokens.Spacing.spacings) {
                if let url = URL(string: character.image) {
                    CachedAsyncImageView(
                        url: url,
                        placeholder: { DefaultPlaceholder() },
                        errorPlaceholder: { DefaultPlaceholder(isLoading: false) }
                    )
                } else {
                    DefaultPlaceholder(isLoading: false)
                }

                VStack(alignment: .leading) {
                    Text(character.name)
                        .font(.headline)
                    Text(character.species)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.vertical, Tokens.Spacing.spacingxxss)
        }
    }
}
