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
        VStack(spacing: 20) {
            
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
            
            VStack(alignment: .leading, spacing: 8) {
                ComponentDetailRow(title: "Status", value: character.status)
                ComponentDetailRow(title: "Species", value: character.species)
                ComponentDetailRow(title: "Gender", value: character.gender)
                ComponentDetailRow(title: "Origin", value: character.origin.name)
                ComponentDetailRow(title: "Last Location", value: character.location.name)
            }
            .padding()
        }
    }
}
