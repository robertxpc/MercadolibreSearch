//
//  MLLoadingView.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 17-04-21.
//

import UIKit

class MLLoadingView: UIView, MLBaseXibView {
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

    func startAnimating() {
        activityIndicatorView.startAnimating()
    }
    func removeLoading() {
        activityIndicatorView.stopAnimating()
        removeFromSuperview()
    }
}
