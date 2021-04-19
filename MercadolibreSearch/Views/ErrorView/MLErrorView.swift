//
//  MLErrorView.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 17-04-21.
//

import UIKit

class MLErrorView: UIView, MLBaseXibView {

    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var button: UIButton?
    private var error: MLError!

    var option: MLError.Options?

    static func instantiate(error: Error) -> MLErrorView {
        let view = instantiate()
        view.configure(with: (error as? MLError) ?? MLError.custom([], error))
        return view
    }

    func configure(with error: MLError) {
        self.error = error
        message.text = error.description
        imageView.image = error.icon

        for case MLError.Options.closeable in error.options {
            option = MLError.Options.closeable
            button?.setTitle("close".localized, for: .normal)
        }

        for case let MLError.Options.retry(function) in error.options {
            option = MLError.Options.retry(function)
            button?.setTitle("retry".localized, for: .normal)
        }
        if option == nil {
            button?.isHidden = true
        }
    }
    @IBAction func buttonPressed(_ sender: Any) {
        switch option {
        case .retry(let function):
                function()
                closeView()
        default:
            closeView()
        }
    }
    func closeView() {
        removeFromSuperview()
    }
}
