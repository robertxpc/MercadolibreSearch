//
//  MLItem.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 18-04-21.
//

import UIKit

struct MLItem: Decodable {

    var id: String
    var title: String?
    var price: Double
    var originalPrice: Double?
    var currencyId: String
    var soldQuantity: Int
    var thumbnail: String?
    var installments: MLInstallments?
    var shipping: MLShippingInfo?
    var condition: MLItemCoditionStatus
    var acceptsMercadopago: Bool
    var availableQuantity: Int
    var pictures: [MLItemPicture]?
    
    private enum CodingKeys: String, CodingKey {
        case id, title, price, thumbnail, installments, shipping, condition, pictures
        case currencyId = "currency_id"
        case soldQuantity = "sold_quantity"
        case originalPrice = "original_price"
        case acceptsMercadopago = "accepts_mercadopago"
        case availableQuantity = "available_quantity"
    }
}
