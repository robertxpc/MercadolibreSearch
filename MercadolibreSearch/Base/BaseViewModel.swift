//
//  BaseViewModel.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 17-04-21.
//

import UIKit
import RxSwift
import RxCocoa

protocol BaseViewModel {
    var router: BaseRouter { get }
    var error: PublishSubject<Error> { get }
    var loading: BehaviorRelay<Bool> { get }

}
