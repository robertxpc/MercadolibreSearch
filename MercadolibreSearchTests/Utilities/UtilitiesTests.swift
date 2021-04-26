//
//  UtilitiesTests.swift
//  MercadolibreSearchTests
//
//  Created by Roberto Parra Castillo on 25-04-21.
//

import XCTest

@testable import MercadolibreSearch

class UtilitiesTests: XCTestCase {
    
    func testDiscountPercent() {
        XCTAssertEqual(Utilities.shared.getDiscountPercent(price: 80, originalPrice: 100), 20)
        
        XCTAssertEqual(Utilities.shared.getDiscountPercent(price: 100, originalPrice: 100), 0)
        
        XCTAssertEqual(Utilities.shared.getDiscountPercent(price: 10000, originalPrice: 20000), 50)
        
        XCTAssertEqual(Utilities.shared.getDiscountPercent(price: 8400, originalPrice: 12000), 30)
        
        XCTAssertEqual(Utilities.shared.getDiscountPercent(price: 25299, originalPrice: 252990), 90)
        
    }
}
