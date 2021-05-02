//
//  MLSearchResultRouter.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 24-04-21.
//

import UIKit

class MLSearchResultRouter: BaseRouter {

    enum PresentationContext {
        case itemDetail(MLItem)
        case search(String)
    }

    weak var baseViewController: UIViewController?

    init(baseViewController: UIViewController) {
        self.baseViewController = baseViewController
    }

    func present(with context: Any?, on viewController: UIViewController?, animated: Bool, completion: (() -> Void)?) {
        guard let presentationContext = context as? PresentationContext else {
            assertionFailure("The context type missmatch")
            return
        }
        switch presentationContext {
        case .itemDetail(let item):
            let searchResult = StoryboardScene.Main.itemDetail.instantiate()

            let viewModel = MLItemDetailViewModel(
                router: MLItemDetailRouter(baseViewController: searchResult),
                inputs: MLItemDetailViewModel.Inputs(
                    repository: APIRestClient.shared,
                    item: item
                )
            )
            searchResult.viewModel = viewModel

            (viewController ?? baseViewController)?.navigationController?
                .pushViewController(searchResult, animated: animated)

        case .search(let text):
            let searchResult = StoryboardScene.Main.searchResult.instantiate()

            let viewModel = MLSearchResultViewModel(
                router: MLSearchResultRouter(baseViewController: searchResult),
                inputs: MLSearchResultViewModel.Inputs(
                    repository: APIRestClient.shared,
                    searchText: text
                )
            )
            searchResult.viewModel = viewModel

            (viewController ?? baseViewController)?.navigationController?
                .pushViewController(searchResult, animated: animated)
        }
    }

    func dismiss(animated: Bool, context: Any?, completion: (() -> Void)?) {
        baseViewController?.dismiss(animated: animated, completion: completion)
    }
}
