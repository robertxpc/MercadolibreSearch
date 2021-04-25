//
//  MLItem+Extensions.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 24-04-21.
//

import UIKit

extension MLItem {
    var formattedPrice: String? {
        NumberFormatter.numberFormater(from: currencyId)
            .string(from: NSNumber(value: price))
    }
    
    var formattedDiscount: String? {
        guard let originalPrice = originalPrice else {
            return nil
        }
        let discountPercent = Utilities.shared.getDiscountPercent(
            price: price,
            originalPrice: originalPrice
        )
        if discountPercent > 0 {
            return String(format: "discount_format".localized, discountPercent)
        }
        return nil
    }
}
