//
//  Utilities.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 24-04-21.
//

import UIKit

class Utilities {
    static var shared = Utilities()

    func getDiscountPercent(price: Double, originalPrice: Double) -> Int {
        return 100 - Int((price / originalPrice) * 100)

    }
}
