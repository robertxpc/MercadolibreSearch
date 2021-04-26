//
//  CarouselView.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 25-04-21.
//

import UIKit

class MLCarouselView: UIView, MLBaseXibView {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var indexLabel: UILabel!

    var images = [MLItemPicture]()
    func configure(images: [MLItemPicture]) {
        self.images = images
        stackView.arrangedSubviews.forEach({$0.removeFromSuperview()})
        for image in images.compactMap({URL(string: $0.secureUrl)}) {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.setImage(fromURL: image, animatedOnce: false, withPlaceholder: #imageLiteral(resourceName: "placeholder-image"))
            stackView.addArrangedSubview(imageView)
            imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        }
        updateIndex(1)
    }
    func updateIndex(_ index: Int) {
        indexLabel.text = "\(index)/\(images.count)"

    }
}
extension MLCarouselView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.size.width
        let page = Int((scrollView.contentOffset.x + (0.5 * width)) / width)

        updateIndex(page + 1)
    }
}
