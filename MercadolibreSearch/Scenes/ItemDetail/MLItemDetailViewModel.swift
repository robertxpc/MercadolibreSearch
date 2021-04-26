//
//  MLItemDetailViewModel.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 25-04-21.
//

import UIKit
import RxSwift
import RxCocoa

class MLItemDetailViewModel: BaseViewModel {
    
    public struct Inputs {
        let repository: MLServiceProtocol
        let item: MLItem
    }
    
    var loading = BehaviorRelay<Bool>(value: false)
    var error = PublishSubject<Error>()
    
    public internal(set) var item = BehaviorRelay<MLItem?>(value: nil)
    public internal(set) var itemDescription = BehaviorRelay<[MLItemDescription]>(value: [])
    
    private(set) var inputs: Inputs
    internal var router: BaseRouter
    private let disposeBag = DisposeBag()
    
    init(router: BaseRouter, inputs: Inputs) {
        self.router = router
        self.inputs = inputs
    }
    func start() {
        if loading.value {
            return
        }
        loading.accept(true)
        inputs
            .repository
            .itemDetail(inputs.item.id)
            .map({
                self.loading.accept(false)
                return $0
            }).subscribe(
                onNext: item.accept,
                onError: {
                    self.loading.accept(false)
                    self.error.onNext(MLError.custom([.retry(self.start)], $0))
                }).disposed(by: disposeBag)
    }
    func getDescription() {
        inputs
            .repository
            .itemDescription(inputs.item.id)
            .subscribe(onNext: itemDescription.accept,
                       onError: error.onNext)
            .disposed(by: disposeBag)
    }
    
}
