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
    
    var formattedAvailableQuantity: String {
        String(format: "stock_format_\(availableQuantity == 1 ? "s" : "p")".localized,
            availableQuantity
        )
    }
    
    func soldQuantityAndConditionString(separator: String = " | ") -> String {
        var conditionText = [String]()
        switch condition {
        case .used: conditionText.append("condition_status_used".localized)
        case .new: conditionText.append("condition_status_new".localized)
        default: break
        }

        if soldQuantity > 0 {
            let formaterMode = soldQuantity == 1 ? "s" : "p"
            conditionText.append(
                String(format: "sold_quantity_formatter_\(formaterMode)".localized, soldQuantity))
        }
        return conditionText.joined(separator: separator)
    }
    
}
