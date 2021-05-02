//
//  MLSearchItemCell.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 24-04-21.
//

import UIKit

class MLSearchItemCell: UICollectionViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var discount: UILabel!
    @IBOutlet weak var stackView: UIStackView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
        itemImage.image = nil
        stackView
            .arrangedSubviews
            .filter({$0.tag == -1})
            .forEach({$0.removeFromSuperview()})
    }
    func bind(item: MLItem) {
        if let image = item.thumbnail, let imageUrl = URL(string: image) {
            itemImage.setImage(fromURL: imageUrl, animatedOnce: false, withPlaceholder: #imageLiteral(resourceName: "placeholder-image"))
        }
        title.text = item.title

        price.text = item.formattedPrice

        discount.text = item.formattedDiscount

        var contentHunggingPriority: Float = 255
        if let installments = item.installments, installments.rate == 0 {
            let installmentsLabel = newLabel(
                contentHunggingPriority: &contentHunggingPriority,
                fontSize: 12
            )
            let installment = installments.installmentsStringFormated
            let installmentRate = installments.rateStringFormated

            let completeInstallmentString = String(
                format: "installments_format".localized,
                installment,
                installmentRate)

            let attrSubString: [String: [NSAttributedString.Key: Any]] = [
                installment: [.foregroundColor: UIColor.systemGreen],
                installmentRate: [.foregroundColor: UIColor.systemGreen]
            ]
            installmentsLabel.attributedText = completeInstallmentString
                .attributedString(
                    baseAttributes: [.font: UIFont.systemFont(ofSize: 12)],
                    attributedSubStrings: attrSubString)

            stackView.addArrangedSubview(installmentsLabel)
        }
        if item.shipping?.freeShipping ?? false {
            let freeShippingLabel = newLabel(
                contentHunggingPriority: &contentHunggingPriority,
                fontSize: 12
            )
            freeShippingLabel.textColor = .systemGreen
            freeShippingLabel.text = "free_shipping".localized
            stackView.addArrangedSubview(freeShippingLabel)

        }
        if item.condition == .used {
            let conditionLabel = newLabel(
                contentHunggingPriority: &contentHunggingPriority,
                fontSize: 12
            )
            conditionLabel.text = "condition_status_used".localized
            stackView.addArrangedSubview(conditionLabel)

        }
    }
    func newLabel(
        contentHunggingPriority: inout Float,
        fontSize: CGFloat
    ) -> UILabel {

        let label = UILabel()
        label.setContentHuggingPriority(
            UILayoutPriority(contentHunggingPriority),
            for: .vertical
        )
        contentHunggingPriority += 1
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.tag = -1

        return label
    }

}
