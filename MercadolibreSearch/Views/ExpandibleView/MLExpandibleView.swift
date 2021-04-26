//
//  MLExpandibleView.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 25-04-21.
//

import UIKit

class MLExpandibleView<T: UIView> {
    var view: T
    var constraint: NSLayoutConstraint?
    init(maxHeight: CGFloat, degradeHeight: CGFloat = 50, bottomColor: UIColor = .white) {
        view = T.init(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true

        let imageView = ExpandUIImageView<T>()
        imageView.expandibleView = self
        imageView.image = #imageLiteral(resourceName: "degrade")
        imageView.tintColor = bottomColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        view.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: degradeHeight).isActive = true

        imageView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: maxHeight).isActive = true
        let constraint = view.heightAnchor.constraint(lessThanOrEqualToConstant: maxHeight)
        constraint.isActive = true
        self.constraint = constraint
        let tapGestureRecognizer = UITapGestureRecognizer(target: imageView, action: #selector(imageView.expand(_:)))
        view.isUserInteractionEnabled = true
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
    }

}
private class ExpandUIImageView<T: UIView>: UIImageView {
    var expandibleView: MLExpandibleView<T>?
    @IBAction func expand(_ sender: UITapGestureRecognizer) {
        expandibleView?.constraint?.isActive = false
        removeFromSuperview()
    }
}
