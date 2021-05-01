//
//  MLSortItem.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 30-04-21.
//

import UIKit

struct MLSortItem: Decodable {

    var id: String
    var name: String
    
    private enum CodingKeys: String, CodingKey {
        case id, name
    }
}
