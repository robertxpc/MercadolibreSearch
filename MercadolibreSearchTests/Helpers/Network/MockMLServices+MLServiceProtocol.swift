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
    
    func search(by text: String, offset: Int, sort: MLSortItem?) -> Observable<MLResponseList<MLItem>> {
        switch mode {
        case .done:
            return getData(for: "done-search-list")
        case .empty:
            return getData(for: "empty-search-list")
        case .error(let error):
            return getError(with: error)
        }
    }
    func itemDetail(_ itemId: String) -> Observable<MLItem> {
        switch mode {
        case .done:
            return getData(for: "done-item-detail")
        case .empty:
            return getData(for: "empty-search-list")
        case .error(let error):
            return getError(with: error)
        }
    }
    func itemDescription(_ itemId: String) -> Observable<[MLItemDescription]> {
        switch mode {
        case .done:
            return getData(for: "done-item-description")
        case .empty:
            return getData(for: "empty-item-description")
        case .error(let error):
            return getError(with: error)
        }
        
    }
}
