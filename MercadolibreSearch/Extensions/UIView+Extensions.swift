//
//  UIView+Extensions.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 17-04-21.
//

import UIKit

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {layer.cornerRadius}
        set {layer.cornerRadius = newValue}
    }
    @IBInspectable
    var borderWidth: CGFloat {
        get {layer.borderWidth}
        set {layer.borderWidth = newValue}
    }
    @IBInspectable
    var borderColor: UIColor {
        get {UIColor(cgColor: layer.borderColor ?? UIColor.clear.cgColor)}
        set {layer.borderColor = newValue.cgColor}
    }

    func fill(with view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

}
