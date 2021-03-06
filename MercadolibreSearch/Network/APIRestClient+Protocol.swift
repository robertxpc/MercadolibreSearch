//
//  APIRestClient+Protocol.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 18-04-21.
//

import Foundation
import Alamofire
import RxSwift

extension APIRestClient: MLServiceProtocol {
    func search(by text: String, offset: Int, sort: MLSortItem?) -> Observable<MLResponseList<MLItem>> {
        var parameters: [String: Any] = [
            "q": text,
            "offset": offset
        ]

        if let sort = sort {
            parameters["sort"] = sort.id
        }
        return request(
            apiPath: site(to: "search"),
            method: .get,
            parameters: parameters,
            encoding: URLEncoding(destination: .queryString)
        )
    }
    func itemDetail(_ itemId: String) -> Observable<MLItem> {
        return request(
            apiPath: "items/\(itemId)",
            method: .get
        )
    }
    func itemDescription(_ itemId: String) -> Observable<[MLItemDescription]> {
        return request(
            apiPath: "items/\(itemId)/descriptions",
            method: .get
        )
    }
}
