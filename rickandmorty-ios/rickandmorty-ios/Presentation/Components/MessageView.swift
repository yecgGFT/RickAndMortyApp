//
//  MessageView.swift
//  rickandmorty-ios
//
//  Created by Chang Chen, Ya-We on 29/1/26.
//

import SwiftUI

struct MessageView: View {
    let message: String
    let showRetry: Bool
    let foregroundColor: Color?
    
    init(message: String, showRetry: Bool = false, color: Color? = nil) {
        self.message = message
        self.showRetry = showRetry
        self.foregroundColor = color
    }

    public var body: some View {
        Text(message)
            .foregroundColor(foregroundColor)
            .padding(.vertical)
        if showRetry {
            Label("Reload", systemImage: "arrow.counterclockwise")
        }
    }
    
    
}
