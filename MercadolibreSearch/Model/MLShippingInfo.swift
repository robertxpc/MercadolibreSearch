//
//  MLShippingInfo.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 24-04-21.
//

import UIKit

class MLShippingInfo: Decodable {
    var freeShipping: Bool = false

    private enum CodingKeys: String, CodingKey {
        case freeShipping = "free_shipping"
    }
}
