//
//  MLSearchResultViewModel.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 24-04-21.
//

import UIKit
import RxSwift
import RxCocoa

class MLSearchResultViewModel: BaseViewModel {
    
    public struct Inputs {
        let repository: MLServiceProtocol
        let searchText: String
    }
    
    var loading = BehaviorRelay<Bool>(value: false)
    var error = PublishSubject<Error>()
    
    private(set) var inputs: Inputs
    internal var router: BaseRouter
    private let disposeBag = DisposeBag()
    
    public internal(set) var data = BehaviorRelay<[MLItem]>(value: [])
    private var listPaging: MLResponseListPaging?
    
    public internal(set) var sorts = BehaviorRelay<[MLSortItem]>(value: [])
    
    init(router: BaseRouter, inputs: Inputs) {
        self.router = router
        self.inputs = inputs
    }
    func start() {
        if loading.value {
            return
        }
        loading.accept(true)
        inputs.repository.search(by: inputs.searchText, offset: 0, sort: sorts.value.first)
            .map({
                self.listPaging = $0.paging
                self.loading.accept(false)
                if ($0.results?.count ?? 0) == 0 {
                    self.error.onNext(MLError.emptySearch([]))
                }
                self.sorts.accept([$0.sort] + $0.availableSorts)
                return $0.results ?? []
            })
            .subscribe(
                onNext: data.accept,
                onError: {
                    self.loading.accept(false)
                    self.error.onNext(MLError.custom([.retry(self.start)], $0))
                }
            ).disposed(by: disposeBag)
    }
    func showItemDetail(_ indexPath: IndexPath) {
        let item = data.value[indexPath.row]
        router.present(with: MLSearchResultRouter.PresentationContext.itemDetail(item), animated: true)
    }
    func loadNextPage() {
        if loading.value {
            return
        }

        var offset = 0
        if let paging = listPaging {
            offset = paging.offset + paging.limit
            if offset >= paging.total {
                return
            }
        }

        loading.accept(true)

        inputs.repository.search(by: inputs.searchText, offset: offset, sort: sorts.value.first)
            .map({
                self.loading.accept(false)
                self.listPaging = $0.paging
                self.sorts.accept([$0.sort] + $0.availableSorts)
                return self.data.value + ($0.results ?? [])
            }).subscribe(
                onNext: data.accept,
                onError: {
                    self.loading.accept(false)
                    self.error.onNext(MLError.custom([.closeable], $0))
                }
            )
            .disposed(by: disposeBag)
    }
    func sortBy(index: Int) {
        print(index)
        guard index != 0 else { return }
        sorts.accept([sorts.value[index]])
        start()
    }
}
