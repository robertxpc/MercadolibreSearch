//
//  SearchViewTests.swift
//  MercadolibreSearchTests
//
//  Created by Roberto Parra Castillo on 30-04-21.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking

@testable import MercadolibreSearch

class SearchViewTests: XCTestCase {
    var services: MockMLServices!
    var router: RouterTest!
    var scheduler: TestScheduler!
    var viewModel: MLSearchViewModel!
    override func setUp() {
        router = RouterTest()
        services = MockMLServices()
        scheduler = TestScheduler(initialClock: 0)

        viewModel = MLSearchViewModel(
            router: router,
            inputs: MLSearchViewModel.Inputs(
                repository: services
            )
        )

        scheduler.start()
    }
    override func tearDown() {
        router = nil
        services = nil
        scheduler.stop()
        scheduler = nil
        viewModel = nil
    }
    func testSearchHistory() {
        let oldCount = viewModel.history.value.count

        viewModel.addToHistory(text: "test1", date: Date())
        viewModel.addToHistory(text: "test2", date: Date())
        XCTAssertEqual(viewModel.history.value.count, oldCount + 2)

        viewModel.clearHistory()
        XCTAssertEqual(viewModel.history.value.count, 0)

        viewModel.saveOrUpdate(text: "test1")
        viewModel.saveOrUpdate(text: "test1")
        XCTAssertEqual(viewModel.history.value.count, 1)
        viewModel.clearHistory()

        viewModel.saveOrUpdate(text: "test1")
        viewModel.saveOrUpdate(text: "MercadoLibre")
        viewModel.saveOrUpdate(text: "test2")
        viewModel.filterSearch("Libre")
        XCTAssertEqual(viewModel.history.value.count, 1)
        XCTAssertEqual(viewModel.history.value.first?.text, "MercadoLibre")

    }

}
