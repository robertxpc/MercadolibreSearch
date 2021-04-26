//
//  MLItemPicture.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 25-04-21.
//

import UIKit

struct MLItemPicture: Decodable {

    var id: String
    var url: String
    var secureUrl: String

    private enum CodingKeys: String, CodingKey {
        case id, url
        case secureUrl = "secure_url"
    }
}
