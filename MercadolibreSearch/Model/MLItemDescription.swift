//
//  MLItemDescription.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 25-04-21.
//

import UIKit

struct MLItemDescription: Decodable {
    var id: String
    var plainText: String
    private enum CodingKeys: String, CodingKey {
        case id
        case plainText = "plain_text"
    }
}
