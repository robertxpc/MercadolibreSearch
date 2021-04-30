//
//  Date+Extensions.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 01-05-21.
//

import Foundation

extension Date {
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.dateTimeStyle = .named
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
