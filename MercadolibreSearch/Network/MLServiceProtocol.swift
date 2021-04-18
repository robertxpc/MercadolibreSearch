//
//  MLServiceProtocol.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 18-04-21.
//

import UIKit
import RxSwift

protocol MLServiceProtocol {
    func search(by text: String, offset: Int) -> Observable<MLResponseList<MLItem>>
}
