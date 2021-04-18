//
//  Logger.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 18-04-21.
//

import UIKit

class Logger {
    enum LogLevel: Int {
        case debug = 4
        case info = 3
        case warning = 2
        case error = 1
        case none = 0
    }
    static var shared = Logger()
    var loglevel: LogLevel = .debug
    func log(_ level: LogLevel, _ items: Any..., separator: String = " ", terminator: String = "\n") {
        if level.rawValue <= loglevel.rawValue {
            print(items, separator: separator, terminator: terminator)
        }
    }
}
