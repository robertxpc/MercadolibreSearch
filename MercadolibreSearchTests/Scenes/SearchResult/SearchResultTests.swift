//
//  SearchResultTests.swift
//  MercadolibreSearchTests
//
//  Created by Roberto Parra Castillo on 25-04-21.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking

@testable import MercadolibreSearch

class SearchResultTests: XCTestCase {
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

    func testSearchOnDone() {
        services.mode = .done

        let disposeBag = DisposeBag()
        let scheduler = TestScheduler(initialClock: 0)

        let viewModel = MLSearchResultViewModel(
            router: router,
            inputs: MLSearchResultViewModel.Inputs(
                repository: services,
                searchText: "iphone"))

        let observer: TestableObserver<Bool> = scheduler.createObserver(Bool.self)

        let correctLoadingExpected: [Recorded<Event<Bool>>] = [
            Recorded.next(0, false),
            Recorded.next(0, true),
            Recorded.next(0, false)
        ]
        let errorsObserver: TestableObserver<Int> = scheduler.createObserver(Int.self)

        viewModel.loading.subscribe(observer).disposed(by: disposeBag)
        viewModel.error.map({_ in 1}).subscribe(errorsObserver).disposed(by: disposeBag)
        let resultObserver: TestableObserver<[MLItem]> = scheduler.createObserver([MLItem].self)

        viewModel.data.subscribe(resultObserver).disposed(by: disposeBag)

        viewModel.start()
        let results = resultObserver.events.last!.value.element!
        XCTAssertEqual(correctLoadingExpected, observer.events)
        XCTAssertGreaterThanOrEqual(results.count, 1)

        viewModel.loadNextPage()

        let resultPaginated = resultObserver.events.last!.value.element!
        XCTAssertGreaterThan(resultPaginated.count, results.count)

        XCTAssertEqual([], errorsObserver.events)
    }

    func testSearchOnEmpty() {
        services.mode = .empty
        let disposeBag = DisposeBag()

        let viewModel = MLSearchResultViewModel(
            router: router,
            inputs: MLSearchResultViewModel.Inputs(
                repository: services,
                searchText: "iphone"))
        let observer: TestableObserver<Bool> = scheduler.createObserver(Bool.self)

        let correctLoadingExpected: [Recorded<Event<Bool>>] = [
            Recorded.next(0, false),
            Recorded.next(0, true),
            Recorded.next(0, false)
        ]
        let errorsObserver: TestableObserver<Error> = scheduler.createObserver(Error.self)

        viewModel.loading.subscribe(observer).disposed(by: disposeBag)
        viewModel.error.subscribe(errorsObserver).disposed(by: disposeBag)
        let resultObserver: TestableObserver<[MLItem]> = scheduler.createObserver([MLItem].self)

        viewModel.data.subscribe(resultObserver).disposed(by: disposeBag)

        viewModel.start()
        let results = resultObserver.events.last!.value.element!
        let error: MLError? = errorsObserver.events.last?.value.element as? MLError
        XCTAssertEqual(correctLoadingExpected, observer.events)
        XCTAssertEqual(results.count, 0)
        XCTAssertEqual(error, MLError.emptySearch([]))
    }
}
