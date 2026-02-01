//
//  Log.swift
//  rickandmorty-ios
//
//  Created by Chang Chen, Ya-We on 17/1/26.
//

import Foundation
import os

enum LogLevel: String {
    case debug = "DEBUG"
    case info = "INFO"
    case notice = "NOTICE"
    case error = "ERROR"
    case fault = "FAULT"
}

enum LogCategory: String {
    case ui = "UI"
    case network = "Network"
    case viewModel = "ViewModel"
    case test = "UnitTest"
    case l10n = "l10n"

}

struct Log {
    private static let subsystem =
        Bundle.main.bundleIdentifier ?? "com.rickandmorty.rickandmorty-ios"

    static func getLogger(_ category: LogCategory) -> Logger {
        return  Logger( subsystem: subsystem, category: LogCategory.viewModel.rawValue)
    }

    static func log(_ level: LogLevel, _ category: LogCategory, _ message: String) {

        if BuildConfiguration.shared.showLog() {
            let logger = Log.getLogger(category)
            switch level {
            case .debug: logger.debug("\(message)")
            case .info: logger.info("\(message)")
            case .notice: logger.notice("\(message)")
            case .error: logger.error("\(message)")
            case .fault: logger.fault("\(message)")
            }
        }
    }

}
