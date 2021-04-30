//
//  MLSearchViewModel.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 18-04-21.
//

import UIKit
import CoreData
import RxSwift
import RxCocoa

class MLSearchViewModel: BaseViewModel {
    
    public struct Inputs {
        let repository: MLServiceProtocol
    }
    var loading = BehaviorRelay<Bool>(value: false)
    var error = PublishSubject<Error>()
    
    private(set) var inputs: Inputs
    internal var router: BaseRouter
    
    private let disposeBag = DisposeBag()
    
    private(set) var history = BehaviorRelay<[MLSearchObject]>(value: [])
    private var historyDataAccessProvider = HistoryDataAccessProvider()
    
    init(router: BaseRouter, inputs: Inputs) {
        self.router = router
        self.inputs = inputs
        self.fetchAndUpdateObservableHistory()
    }
    
    private func fetchAndUpdateObservableHistory() {
        historyDataAccessProvider.fetchObservableData()
            
            .map({ $0 })
            
            .subscribe(onNext : {
                self.history.accept($0)
            }).disposed(by: disposeBag)
    }
    public func addToHistory(text: String, date: Date = Date()) {
        
        historyDataAccessProvider.addSearchObject(
            text: text,
            mode: "search",
            lastUpdate: date
        )
    }
    func historySelected(index: Int) {
        guard let text = history.value[index].text else { return }
        historyDataAccessProvider.updateDate(with: Date(), in: index)
        search(text: text)
    }
    func search(text: String) -> Bool {

        guard text.count > 2 else { return false }
        
        router.present(
            with: MLSearchRouter.PresentationContext.search(text),
            animated: true
        )
        return true
    }
    func saveOrUpdate(text: String) {
        if let index = history.value.lastIndex(where: {$0.text == text})  {
            historyDataAccessProvider.updateDate(with: Date(), in: index)
        } else {
            historyDataAccessProvider.addSearchObject(
                text: text,
                mode: "search",
                lastUpdate: Date()
            )
        }
    }
    func clearHistory() {
        historyDataAccessProvider.removeAll()
    }
    func filterSearch(_ filter: String) {
        historyDataAccessProvider.filter = filter
    }
}
