//
//  MessageView.swift
//  rickandmorty-ios
//
//  Created by Chang Chen, Ya-We on 29/1/26.
//

import SwiftUI

struct MessageViewModel {

    let message: String
    let retryText: String?
    let fgColor: Color?
    let bgColor: Color

    init(
        message: String,
        retryText: String? = nil,
        fgColor: Color? = nil,
        bgColor: Color = .clear
    ) {
        self.message = message
        self.retryText = retryText
        self.fgColor = fgColor
        self.bgColor = bgColor
    }
}

struct MessageView: View {
    var model: MessageViewModel
    var tapSelector: (() -> Void)?

    init(model: MessageViewModel, tapSelector: (() -> Void)? = nil) {
        self.model = model
        self.tapSelector = tapSelector
    }

    public var body: some View {
        VStack {
            Text(model.message)
                .foregroundColor(model.fgColor)
                .padding(.vertical)
            if let retryText = model.retryText {
                Label(retryText, systemImage: "arrow.counterclockwise")
                    .onTapGesture {
                        tapSelector?()
                    }
            }
        }.background(model.bgColor)
    }
}
extension MessageView {
    public func onTapSelector(_ action: @escaping (() -> Void)) -> MessageView {
        var new = self
        new.tapSelector = action
        return new
    }
}

#Preview("Mensaje simple") {
    MessageView(model: .init(message: "Hola mundo"))
        .padding()
}

#Preview("Con reintento") {
    MessageView(
        model: .init(
            message: "Algo salió mal. Intenta de nuevo.",
            retryText: "Reintentar"
        )
    ).onTapSelector {
        print("Tap hecho!")
    }
    .padding()
}

#Preview("Color personalizado") {
    MessageView(model: .init(message: "Mensaje destacado", fgColor: .blue))
        .padding()
}
