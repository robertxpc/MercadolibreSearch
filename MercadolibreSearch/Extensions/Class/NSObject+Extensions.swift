//
//  NSObject+Extensions.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 01-05-21.
//

import Foundation

extension NSObject {
    
    func loadWith(dictionary: [String: Any]) {
        for attr in dictionary {
            self.setValue(attr.value, forKey: attr.key)
        }
    }
}
