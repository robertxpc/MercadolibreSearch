//
//  MLSortView.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 30-04-21.
//

import UIKit
import RxSwift
import RxCocoa

class MLSortView: UIView, MLBaseXibView {

    let disposeBag = DisposeBag()
    @IBOutlet weak var tableView: UITableView!
    let sortItems = BehaviorRelay<[MLSortItem]>(value: [])
    let onItemSelected = PublishSubject<Int>()

    override func awakeFromNib() {

        tableView.register(
            UINib(nibName: "MLSortViewTableViewCell", bundle: nil),
            forCellReuseIdentifier: String(describing: MLSortViewTableViewCell.self)
        )

        sortItems
            .asObservable()
            .bind(to: tableView.rx.items(
                    cellIdentifier: "MLSortViewTableViewCell",
                    cellType: MLSortViewTableViewCell.self),
                  curriedArgument: { index, item, cell in
                    cell.bind(item, isSelected: index == 0)
                  }
            ).disposed(by: disposeBag)

        tableView
            .rx
            .itemSelected
            .subscribe(onNext: {
                self.onItemSelected.onNext($0.row)
                self.closeView()
            })
            .disposed(by: disposeBag)

    }

    @IBAction func closeView() {
        removeFromSuperview()
    }
}
