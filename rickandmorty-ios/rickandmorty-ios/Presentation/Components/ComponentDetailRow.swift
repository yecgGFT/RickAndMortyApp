//
//  ComponentDetailRow.swift
//  rickandmorty-ios
//
//  Created by Chang Chen, Ya-We on 29/1/26.
//

import SwiftUI

struct ComponentDetailRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title).fontWeight(.semibold)
            Spacer()
            Text(value).foregroundColor(.secondary)
        }
        .font(.title3)
    }
}
