//
//  MLItemDetailViewController.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 25-04-21.
//

import UIKit
import RxSwift

class MLItemDetailViewController: UIViewController, BaseViewController {

    weak var loadingView: MLLoadingView?
    weak var errorView: MLErrorView?
    var viewModel: MLItemDetailViewModel!
    let disposeBag = DisposeBag()

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var productCondition: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var picturesContainer: UIView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var discountPrice: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var descriptionTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bindViewModel()
        viewModel.start()
        viewModel.getDescription()
    }

    func bindViewModel() {

        viewModel
            .loading
            .subscribe(onNext: showLoading)
            .disposed(by: disposeBag)

        viewModel
            .error
            .subscribe(onNext: show(error:))
            .disposed(by: disposeBag)
        viewModel
            .item
            .subscribe(onNext: configure(item:))
            .disposed(by: disposeBag)

        viewModel
            .itemDescription
            .subscribe(onNext: configure(descriptions:))
            .disposed(by: disposeBag)
    }
    func setupUI() {

    }
    func configure(item: MLItem?) {
        guard let item = item else {
            return
        }
        var contentHunggingPriority: Float = 255

        if let images = item.pictures {
            let carousel = MLCarouselView.instantiate()
            picturesContainer.fill(with: carousel)
            carousel.configure(images: images)
        }

        productCondition.text = item.soldQuantityAndConditionString()
        titleLabel.text = item.title

        price.text = item.formattedPrice

        discountPrice.text = item.formattedDiscount

        if let installments = item.installments ?? viewModel.inputs.item.installments {
            let installmentsLabel = UILabel()
            installmentsLabel.font = UIFont.systemFont(ofSize: 16)
            installmentsLabel.tag = -1
            installmentsLabel.setContentHuggingPriority(
                UILayoutPriority(contentHunggingPriority),
                for: .vertical
            )
            contentHunggingPriority += 1
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
                    baseAttributes: [.font: UIFont.systemFont(ofSize: 16)],
                    attributedSubStrings: attrSubString)

            stackView.insertArrangedSubview(
                installmentsLabel,
                at: stackView.arrangedSubviews.index(after: stackView.arrangedSubviews.lastIndex(of: price.superview ?? UIView()) ?? 3))

        }

        let stockCompleteMutableString = NSMutableAttributedString(
            string: item.formattedAvailableQuantity,
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)
            ]
        )
        stockCompleteMutableString.addAttribute(
            .font,
            value: UIFont.boldSystemFont(ofSize: 16),
            range: NSString(string: item.formattedAvailableQuantity).range(of: "stock_format_title".localized)
        )
        stockLabel.attributedText = stockCompleteMutableString
        print(item)
    }
    func configure(descriptions: [MLItemDescription]) {
        guard let description = descriptions.last else {
            descriptionLabel?.text = nil
            descriptionTitleLabel.text = nil
            return
        }
        if descriptionLabel == nil {
            let descriptionLabel = MLExpandibleView<UILabel>(maxHeight: 200, bottomColor: .white).view
            descriptionLabel.numberOfLines = 0
            descriptionLabel.font = UIFont.systemFont(ofSize: 14)
            stackView.insertArrangedSubview(
                descriptionLabel,
                at: stackView.arrangedSubviews.index(
                    after: stackView.arrangedSubviews.lastIndex(of: descriptionTitleLabel) ?? 0))
            self.descriptionLabel = descriptionLabel
        }
        descriptionTitleLabel.text = "description_title".localized
        descriptionLabel?.text = description.plainText
    }
}
