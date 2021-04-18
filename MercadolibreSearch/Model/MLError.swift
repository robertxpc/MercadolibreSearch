//
//  MLError.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 17-04-21.
//

import UIKit

enum MLError: Error {
    enum Options {
        case closeable, retry(() -> Void)
    }
    case notFound([Options]),
         noInternet([Options]),
         emptySearch([Options]),
         custom([Options], Error)

    var options: [Options] {
        switch self {
        case .noInternet(let options): return options
        case .emptySearch(let options): return options
        case .notFound(let options): return options
        case .custom(let options, _): return options

        }
    }
}
