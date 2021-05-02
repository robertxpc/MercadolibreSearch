//
//  ItemDetailTests.swift
//  MercadolibreSearchTests
//
//  Created by Roberto Parra Castillo on 25-04-21.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking

@testable import MercadolibreSearch

class ItemDetailTests: XCTestCase {
    var services: MockMLServices!
    var router: RouterTest!
    var scheduler: TestScheduler!

    override func setUp() {
        router = RouterTest()
        services = MockMLServices()
        scheduler = TestScheduler(initialClock: 0)
        scheduler.start()
    }

    override func tearDown() {
        router = nil
        services = nil
        scheduler.stop()
        scheduler = nil
    }
    func testItemDetailOnDone() {
        services.mode = .done

        let item = MLItem(
            id: "MLC-TEST",
            title: nil,
            price: 100,
            originalPrice: nil,
            currencyId: "CLP",
            soldQuantity: 1,
            thumbnail: nil,
            installments: nil,
            shipping: nil,
            condition: .new,
            acceptsMercadopago: true,
            availableQuantity: 1,
            pictures: nil)

        let disposeBag = DisposeBag()
        let scheduler = TestScheduler(initialClock: 0)

        let viewModel = MLItemDetailViewModel(
            router: router,
            inputs: MLItemDetailViewModel.Inputs(
                repository: services,
                item: item))

        let observer: TestableObserver<Bool> = scheduler.createObserver(Bool.self)

        let correctLoadingExpected: [Recorded<Event<Bool>>] = [
            Recorded.next(0, false),
            Recorded.next(0, true),
            Recorded.next(0, false)
        ]
        let errorsObserver: TestableObserver<Int> = scheduler.createObserver(Int.self)

        viewModel.loading.subscribe(observer).disposed(by: disposeBag)
        viewModel.error.map({_ in 1}).subscribe(errorsObserver).disposed(by: disposeBag)
        let resultObserver: TestableObserver<MLItem?> = scheduler.createObserver(MLItem?.self)

        viewModel.item.subscribe(resultObserver).disposed(by: disposeBag)

        viewModel.start()
        let results = resultObserver.events.last!.value.element!
        XCTAssertEqual(correctLoadingExpected, observer.events)
        XCTAssertNotNil(results)

        XCTAssertEqual([], errorsObserver.events)
    }
    func testItemDescriptionOnDone() {
        services.mode = .done

        let item = MLItem(
            id: "MLC-TEST",
            title: nil,
            price: 100,
            originalPrice: nil,
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

        let disposeBag = DisposeBag()
        let scheduler = TestScheduler(initialClock: 0)

        let viewModel = MLItemDetailViewModel(
            router: router,
            inputs: MLItemDetailViewModel.Inputs(
                repository: services,
                item: item))

        let observer: TestableObserver<Bool> = scheduler.createObserver(Bool.self)

        let correctLoadingExpected: [Recorded<Event<Bool>>] = [
            Recorded.next(0, false)
        ]
        let errorsObserver: TestableObserver<Int> = scheduler.createObserver(Int.self)

        viewModel.loading.subscribe(observer).disposed(by: disposeBag)
        viewModel.error.map({_ in 1}).subscribe(errorsObserver).disposed(by: disposeBag)
        let resultObserver: TestableObserver<[MLItemDescription]> = scheduler.createObserver([MLItemDescription].self)

        viewModel.itemDescription.subscribe(resultObserver).disposed(by: disposeBag)

        viewModel.getDescription()
        let results = resultObserver.events.last!.value.element!
        XCTAssertEqual(correctLoadingExpected, observer.events)
        XCTAssertGreaterThan(results.count, 0)
        XCTAssertEqual([], errorsObserver.events)
    }

}
