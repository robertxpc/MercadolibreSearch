//___FILEHEADER___

import UIKit
import RxSwift

class ___FILEBASENAMEASIDENTIFIER___: UIViewController, BaseViewController {

    weak var loadingView: <#LoadingView?#>
    weak var errorView: <#ErrorView?#>
    var viewModel: ___VARIABLE_productName:identifier___ViewModel!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bindViewModel()
        // Do any additional setup after loading the view.
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
        // Do any additional bind to view model.
    }
    func setupUI() {

    }
}
