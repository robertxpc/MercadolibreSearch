//
//  MLSearchRouter.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 18-04-21.
//

import UIKit

class MLSearchRouter: BaseRouter {
    
    enum PresentationContext {
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
        case .search(let text):
            Logger.shared.log(.debug, "go to search result with \(text)")
        }
        
    }
    
    func dismiss(animated: Bool, context: Any?, completion: (() -> Void)?) {
        baseViewController?.dismiss(animated: animated, completion: completion)
    }
}
