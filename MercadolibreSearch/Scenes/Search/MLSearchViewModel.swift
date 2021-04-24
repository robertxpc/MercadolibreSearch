//
//  MLSearchViewModel.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 18-04-21.
//

import UIKit
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
    
    init(router: BaseRouter, inputs: Inputs) {
        self.router = router
        self.inputs = inputs
    }
    func search(text: String) {

        guard text.count > 2 else {
            return
        }
        router.present(
            with: MLSearchRouter.PresentationContext.search(text),
            animated: true
        )

    }
    
}
