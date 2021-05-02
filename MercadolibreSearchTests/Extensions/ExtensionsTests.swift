//
//  ExtensionsTests.swift
//  MercadolibreSearchTests
//
//  Created by Roberto Parra Castillo on 25-04-21.
//

import XCTest

@testable import MercadolibreSearch

class ExtensionsTests: XCTestCase {
    func testMLInstallments() {
        let installments = MLInstallments()
        installments.quantity = 6
        installments.amount = 100000
        installments.rate = 0
        installments.currencyId = "CLP"

        XCTAssertEqual(installments.installmentsStringFormated, "6x CLP 100.000")
        XCTAssertEqual(installments.rateStringFormated, "not_rate_installment".localized)

        installments.rate = 0.2
        XCTAssertEqual(installments.rateStringFormated, "")

        installments.rate = 0
        installments.quantity = 12
        installments.currencyId = "USD"
        installments.amount = 55.95
        XCTAssertEqual(installments.installmentsStringFormated, "12x US$ 55,95")
    }

    func testMLItemExtensions() {
        let item = MLItem(
            id: "MLC-TEST",
            title: nil,
            price: 1000,
            originalPrice: 95000,
            currencyId: "CLP",
            soldQuantity: 1,
            thumbnail: nil,
            installments: nil,
            shipping: nil,
            condition: .new,
            acceptsMercadopago: true,
            availableQuantity: 1,
            pictures: nil
            )

        XCTAssertEqual(item.soldQuantityAndConditionString(separator: "."), "Nuevo.1 vendido")
        XCTAssertEqual(item.soldQuantityAndConditionString(), "Nuevo | 1 vendido")
        XCTAssertEqual(item.formattedPrice, "CLP 1.000")
        XCTAssertEqual(item.formattedDiscount, "99% OFF")
        XCTAssertEqual(item.formattedAvailableQuantity, "Stock: 1 disponible")

    }
    func testNSObject() {
        // swiftlint:disable:next force_cast
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = delegate.persistentContainer.viewContext
        let filledVar = MLSearchObject(context: managedObjectContext)

        let dict: [String: Any] = [
            "text": "Hola",
            "mode": "search",
            "lastUpdate": Date()
        ]
        filledVar.loadWith(dictionary: dict)

        XCTAssertEqual(filledVar.text, dict["text"] as? String)
        XCTAssertEqual(filledVar.mode, dict["mode"] as? String)
        XCTAssertEqual(filledVar.lastUpdate, dict["lastUpdate"] as? Date)
    }
}
