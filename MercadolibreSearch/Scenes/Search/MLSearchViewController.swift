//
//  MLSearchViewController.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 18-04-21.
//

import UIKit
import RxSwift

class MLSearchViewController: UIViewController, BaseViewController {

    weak var loadingView: MLLoadingView?
    weak var errorView: MLErrorView?
    var viewModel: MLSearchViewModel!
    let disposeBag = DisposeBag()

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = MLSearchViewModel(
            router: MLSearchRouter(baseViewController: self),
            inputs: MLSearchViewModel.Inputs(
                repository: APIRestClient.shared
            )
        )
        
        setupUI()
        bindViewModel()
        // Do any additional setup after loading the view.
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
        // Do any additional bind to view model.
    }
    func setupUI() {

    }
}
