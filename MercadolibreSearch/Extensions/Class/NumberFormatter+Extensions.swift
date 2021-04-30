//
//  NumberFormatter+Extensions.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 24-04-21.
//

import Foundation

extension NumberFormatter {
    static func numberFormater(from currencyCode: String) -> NumberFormatter {
        let localeIdentifier = NSLocale.localeIdentifier(
            fromComponents: [NSLocale.Key.currencyCode.rawValue: currencyCode]
        )
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: localeIdentifier)
        numberFormatter.currencyGroupingSeparator = "."
        numberFormatter.currencyDecimalSeparator = ","
        numberFormatter.numberStyle = .currency
        return numberFormatter
    }
}
