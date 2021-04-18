//
//  MLResponseList.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 18-04-21.
//

import UIKit

struct MLResponseList<Type: Decodable>: Decodable {

    var results: [Type]?

    private enum CodingKeys: String, CodingKey {
        case results
    }
}
