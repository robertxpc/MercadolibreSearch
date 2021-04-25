//
//  MLInstallments+Extensions.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 24-04-21.
//

import UIKit

extension MLInstallments {
    var installmentsStringFormated: String {
        let numberFormatter = NumberFormatter.numberFormater(from: currencyId ?? "")
        let formatedAmount = numberFormatter.string(from: NSNumber(value: amount ?? 0)) ?? ""
        return "\(quantity ?? 1)x \(formatedAmount)"
    }
    var rateStringFormated: String {
        return rate == 0 ? "not_rate_installment".localized : ""
    }
}
