//
//  MLSearchResultViewController.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 24-04-21.
//

import UIKit
import RxSwift

class MLSearchResultViewController: UIViewController, BaseViewController {

    weak var loadingView: MLLoadingView?
    weak var errorView: MLErrorView?
    var viewModel: MLSearchResultViewModel!
    let disposeBag = DisposeBag()

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bindViewModel()
        viewModel.start()
    }

    func bindViewModel() {

        viewModel
            .loading
            .subscribe(onNext: showLoading)
            .disposed(by: disposeBag)

        viewModel
            .error
            .subscribe(onNext: show(error:))
            .disposed(by: disposeBag)

        viewModel.data.bind(
            to: collectionView.rx.items(
                cellIdentifier: "MLSearchItemCell",
                cellType: MLSearchItemCell.self)
        ) { _, item, cell in
            cell.bind(item: item)
        }.disposed(by: disposeBag)

        collectionView
            .rx
            .reachedBottom
            .subscribe(onNext: viewModel.loadNextPage)
            .disposed(by: disposeBag)

        collectionView
            .rx
            .itemSelected
            .subscribe(onNext: viewModel.showItemDetail)
            .disposed(by: disposeBag)

    }
    @IBAction func sortPressed(_ sender: Any) {
        let sortView = MLSortView.instantiate()
        viewModel.sorts.bind(
            to: sortView.sortItems
        ).disposed(by: disposeBag)

        sortView.onItemSelected.subscribe(
            onNext: viewModel.sortBy
            ).disposed(by: disposeBag)
        view.fill(with: sortView)
    }
    func setupUI() {
        collectionView.register(UINib(nibName: "MLSearchItemCell", bundle: nil), forCellWithReuseIdentifier: String(describing: MLSearchItemCell.self))
        collectionView.setShadow()
        title = viewModel.inputs.searchText
    }
}
