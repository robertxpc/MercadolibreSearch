//
//  MLLoadingView.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 17-04-21.
//

import UIKit

class MLLoadingView: UIView {
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

    static func instantiate() -> MLLoadingView {
        let view = Bundle.main.loadNibNamed("MLLoadingView", owner: nil, options: nil)?.first as! MLLoadingView

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    func startAnimating() {
        activityIndicatorView.startAnimating()
    }
    func removeLoading() {
        activityIndicatorView.stopAnimating()
        removeFromSuperview()
    }
}
