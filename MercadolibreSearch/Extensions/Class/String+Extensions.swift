//
//  String+Extensions.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 17-04-21.
//

import UIKit

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    func attributedString(
        baseAttributes:[NSAttributedString.Key: Any],
        attributedSubStrings: [String: [NSAttributedString.Key: Any]]
    ) -> NSAttributedString {
        
        let mutableString = NSMutableAttributedString(
            string: self,
            attributes: baseAttributes
        )
        for item in attributedSubStrings {
            mutableString.addAttributes(
                item.value,
                range: NSString(string: self).range(of: item.key))
        }
        return mutableString
    }
}
