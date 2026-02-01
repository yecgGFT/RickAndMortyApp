//
//  Image+Extensions.swift
//  rickandmorty-ios
//
//  Created by Chang Chen, Ya-We on 18/1/26.
//

import SwiftUI

extension Image {
    func toUIImage(scale: CGFloat) -> UIImage? {
        let renderer = ImageRenderer(content: self)
        renderer.scale = scale
        return renderer.uiImage
    }
}
