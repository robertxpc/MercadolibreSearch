//
//  BaseViewController.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 17-04-21.
//

import UIKit

protocol BaseViewController: UIViewController {
    var loadingView: MLLoadingView? { get set }
    var errorView: MLErrorView? { get set }
    func bindViewModel()
    func setupUI()
    func showLoading(_ status: Bool)
    func show(error: Error)
}
extension BaseViewController {

    func showLoading(_ status: Bool) {
        if status {
            if loadingView == nil {
                let loadingView = MLLoadingView.instantiate()
                view.fill(with: loadingView)
                loadingView.startAnimating()

                self.loadingView = loadingView
            }
        } else {
            loadingView?.removeLoading()
        }
    }
    func show(error: Error) {
        errorView?.removeFromSuperview()
        let errorView = MLErrorView.instantiate(error: error)
        view.fill(with: errorView)
        self.errorView = errorView
    }
}
