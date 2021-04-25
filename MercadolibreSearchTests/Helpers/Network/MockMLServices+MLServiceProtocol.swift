//
//  MockMLServices+MLServiceProtocol.swift
//  MercadolibreSearchTests
//
//  Created by Roberto Parra Castillo on 25-04-21.
//

import XCTest
import UIKit
import RxTest
import RxSwift

@testable import MercadolibreSearch

extension MockMLServices: MLServiceProtocol {
    
    func search(by text: String, offset: Int) -> Observable<MLResponseList<MLItem>> {
        switch mode {
        case .done:
            return getData(for: "done-search-list")
        case .empty:
            return getData(for: "empty-search-list")
        case .error(let error):
            return getError(with: error)
        }
    }
    
}
