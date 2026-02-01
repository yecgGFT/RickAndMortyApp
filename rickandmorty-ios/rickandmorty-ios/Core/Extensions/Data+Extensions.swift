//
//  Data+Extensions.swift
//  rickandmorty-ios
//
//  Created by Chang Chen, Ya-We on 29/1/26.
//

import Foundation

extension Data {
    public var prettyPrintedJSONString: String? {
        guard
            let object = try? JSONSerialization.jsonObject(
                with: self,
                options: []
            ),
            let data = try? JSONSerialization.data(
                withJSONObject: object,
                options: [.prettyPrinted]
            ),
            let prettyPrintedString = String(data: data, encoding: .utf8)
        else { return nil }

        return prettyPrintedString
    }
}
