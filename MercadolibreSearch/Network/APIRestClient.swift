//
//  APIRestClient.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 18-04-21.
//

import Foundation
import Alamofire
import RxSwift

class APIRestClient {

    private enum Sites: String {
        case chile = "MLC"
        case brazil = "MLB"
        case argentina = "MLA"
    }

    static let shared: APIRestClient = APIRestClient()
    private var server = "https://api.mercadolibre.com/"
    private var site: Sites = .chile
    func apiPath(path: String) -> URL? {
        guard let url = URL(string: server) else {
            return nil
        }
        return url.appendingPathComponent(path)
    }
    func site(to path: String) -> String {
        let path: [String] = path
            .trimmingCharacters(in: .whitespaces)
            .split(separator: "/")
            .compactMap(String.init)

        return (["sites", site.rawValue] + path).joined(separator: "/")
    }

    private init() {}

    open func request<T: Decodable>(
        _ convertible: URLConvertible? = nil,
        apiPath: String = "",
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil,
        interceptor: RequestInterceptor? = nil
    ) ->  Observable<T> {
        return Observable.create { observer -> Disposable in
            AF.request(
                convertible ?? self.apiPath(path: apiPath) ?? "",
                method: method,
                parameters: parameters,
                encoding: encoding,
                headers: headers,
                interceptor: interceptor
            ).validate()
            .cURLDescription(calling: {Logger.shared.log(.debug, $0)})
            .responseDecodable(
                completionHandler: { (response: DataResponse<T, AFError>) in
                    switch response.result {
                    case .success(let response):
                        observer.onNext(response)
                    case .failure(let error):
                        Logger.shared.log(.error, error)
                        switch error {
                        case .sessionTaskFailed(let sessionError):
                            if let urlError = sessionError as? URLError {
                                return observer.onError(urlError)
                            }
                        default:
                            break
                        }
                        observer.onError(error)
                    }
                })
            return Disposables.create()
        }
    }
}
