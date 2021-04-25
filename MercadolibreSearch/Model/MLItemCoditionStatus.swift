//
//  MLItemCoditionStatus.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 24-04-21.
//

import UIKit

enum MLItemCoditionStatus: String, Decodable {
    case new, used
    case notSpecified = "not_specified"
}
