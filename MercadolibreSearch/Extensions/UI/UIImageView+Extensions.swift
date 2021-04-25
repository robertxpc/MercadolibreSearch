//
//  UIImageView+Extensions.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 24-04-21.
//

import UIKit
import Alamofire
import AlamofireImage

extension UIImageView {

    func setImage(fromURL url: URL, animatedOnce: Bool = true, withPlaceholder placeholderImage: UIImage? = nil) {
        let hasImage: Bool = (image != nil)
        af.setImage(
            withURL: url,
            placeholderImage: placeholderImage,
            imageTransition: animatedOnce ? .crossDissolve(0.3) : .noTransition,
            runImageTransitionIfCached: hasImage
        )
    }
}
