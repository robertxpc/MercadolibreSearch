//
//  MLBaseXibView.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 18-04-21.
//

import UIKit

protocol MLBaseXibView: UIView {
    static func instantiate() -> Self
    
}
extension MLBaseXibView {
    static func instantiate() -> Self {
        let view = Bundle.main.loadNibNamed("\(Self.self)", owner: nil, options: nil)?.first as! Self

        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }
}
