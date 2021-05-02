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
    @IBOutlet weak var clearHistoryButton: UIButton!
    @IBOutlet weak var clearHistoryButtonHeight: NSLayoutConstraint!

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

        viewModel.history.bind(
            to: tableView.rx.items(
                cellIdentifier: "MLSearchTableViewCell",
                cellType: MLSearchTableViewCell.self)
        ) { _, item, cell in
            cell.bind(item: item)
        }.disposed(by: disposeBag)

        viewModel
            .history
            .bind(onNext: {self.clearHistoryButtonHeight.constant = $0.count == 0 ? 0 : 35})
            .disposed(by: disposeBag)

        tableView
            .rx
            .itemSelected
            .subscribe(onNext: {self.viewModel.historySelected(index: $0.row)})
            .disposed(by: disposeBag)
    }

    func setupUI() {

        clearHistoryButton
            .rx
            .tap
            .subscribe(onNext: clearHistory)
            .disposed(by: disposeBag)

        searchBar
            .rx
            .text
            .orEmpty
            .throttle(DispatchTimeInterval.milliseconds(300), scheduler: MainScheduler.instance)
            .subscribe(onNext: viewModel.filterSearch)
            .disposed(by: disposeBag)

        searchBar
            .rx
            .searchButtonClicked
            .subscribe(onNext: { [self] in
                self.searchBar.resignFirstResponder()
                if let searchText = self.searchBar.text {
                    if self.viewModel.search(text: searchText) {
                        self.viewModel.saveOrUpdate(text: searchText)
                        self.searchBar.text = ""
                        self.viewModel.filterSearch("")
                    }

                }
            }).disposed(by: disposeBag)

        tableView.register(
            UINib(nibName: "MLSearchTableViewCell", bundle: nil),
            forCellReuseIdentifier: String(describing: MLSearchTableViewCell.self)
        )

        tableView.setShadow()

        clearHistoryButton.setTitle("clear_history".localized, for: .normal)
    }
    func clearHistory() {
        let alertController = UIAlertController(
            title: "clear_history_answer".localized,
            message: nil,
            preferredStyle: .alert
        )
        alertController.addAction(
            UIAlertAction(
                title: "clear".localized,
                style: .destructive,
                handler: { _ in
                    self.viewModel.clearHistory()
                    alertController.dismiss(animated: true, completion: nil)
                }
            ))
        alertController.addAction(
            UIAlertAction(
                title: "cancel".localized,
                style: .cancel,
                handler: { _ in
                    alertController.dismiss(animated: true, completion: nil)
                }
            ))
        present(alertController, animated: true, completion: nil)
    }
}
