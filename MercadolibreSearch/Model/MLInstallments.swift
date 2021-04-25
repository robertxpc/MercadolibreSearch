//
//  MLInstallments.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 24-04-21.
//

import UIKit

class MLInstallments: Decodable {

    var quantity: Int?
    var amount: Double?
    var currencyId: String?
    var rate: Double?

    private enum CodingKeys: String, CodingKey {
        case quantity, amount, rate
        case currencyId = "currency_id"

    }
}
