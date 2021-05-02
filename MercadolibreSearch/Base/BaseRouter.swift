//
//  BaseRouter.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 17-04-21.
//

import UIKit

protocol BaseRouter {
    var baseViewController: UIViewController? { get set }

    func present(with context: Any?, on viewController: UIViewController?, animated: Bool, completion: (() -> Void)?)

    func dismiss(animated: Bool, context: Any?, completion: (() -> Void)?)

}
extension BaseRouter {
    func present(with context: Any?, animated: Bool, completion: (() -> Void)?) {
        present(with: context, on: nil, animated: animated, completion: completion)
    }
    func present(with context: Any?, animated: Bool) {
        present(with: context, on: nil, animated: animated, completion: nil)
    }
    func present(with context: Any?, on viewController: UIViewController?, animated: Bool) {
        present(with: context, on: viewController, animated: animated, completion: nil)
    }

    func dismiss(animated: Bool, completion: (() -> Void)?) {
        dismiss(animated: animated, context: nil, completion: completion)
    }
    func dismiss(animated: Bool, context: Any?) {
        dismiss(animated: animated, context: context, completion: nil)
    }
    func dismiss(animated: Bool) {
        dismiss(animated: animated, context: nil, completion: nil)
    }

}
