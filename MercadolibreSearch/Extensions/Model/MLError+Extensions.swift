//
//  MLError+Extensions.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 17-04-21.
//

import UIKit

extension MLError {
    var description: String {
        switch self {
        case .notFound:
            return "not_found_error".localized
        case .noInternet:
            return "no_internet_message".localized
        case .emptySearch:
            return "no_product_available".localized
        case .custom(_, let error):
            if let urlError = error as? URLError,
               urlError.code.rawValue == -1009 {
                return "no_internet_message".localized
            }

            return error.localizedDescription
        }
    }
    var icon: UIImage {
        switch self {
        case .noInternet:
            return #imageLiteral(resourceName: "internet-error")
        case .custom(_, let error):
            if let urlError = error as? URLError,
               urlError.code.rawValue == -1009 {
                return #imageLiteral(resourceName: "internet-error")
            }
        default: break
        }
        return #imageLiteral(resourceName: "icon-warning")
    }
}

extension MLError: Equatable {
    static func == (lhs: MLError, rhs: MLError) -> Bool {
        switch (lhs, rhs) {
        case (.noInternet, .noInternet): return true
        case (.emptySearch, .emptySearch): return true
        case (.notFound, .notFound): return true
        case (.custom(_, let lhsError), custom(_, let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}
