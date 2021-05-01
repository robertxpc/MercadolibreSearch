//
//  MLServiceProtocol.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 18-04-21.
//

import UIKit
import RxSwift

protocol MLServiceProtocol {
    func search(by text: String, offset: Int, sort: MLSortItem?) -> Observable<MLResponseList<MLItem>>
    func itemDetail(_ itemId: String) -> Observable<MLItem>
    func itemDescription(_ itemId: String) -> Observable<[MLItemDescription]>
}
