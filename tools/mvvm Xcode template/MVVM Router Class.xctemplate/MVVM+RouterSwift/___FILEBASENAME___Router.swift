//___FILEHEADER___

import UIKit

class ___FILEBASENAMEASIDENTIFIER___: BaseRouter {
    
    enum PresentationContext {

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
        
    }
    
    func dismiss(animated: Bool, context: Any?, completion: (() -> Void)?) {
        baseViewController?.dismiss(animated: animated, completion: completion)
    }
}
