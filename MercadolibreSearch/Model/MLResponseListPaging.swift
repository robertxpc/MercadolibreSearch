//
//  MLResponseListPaging.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 24-04-21.
//

import UIKit

struct MLResponseListPaging: Decodable {

    var total: Int = 0
    var offset: Int = 0
    var limit: Int = 0

    private enum CodingKeys: String, CodingKey {
        case total, offset, limit

    }

}
