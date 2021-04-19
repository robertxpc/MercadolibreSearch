//
//  MockMLServices.swift
//  MercadolibreSearchTests
//
//  Created by Roberto Parra Castillo on 18-04-21.
//

import XCTest
import UIKit
import RxTest
import RxSwift

@testable import MercadolibreSearch

class MockMLServices {
    enum Modes {
        case done, empty, error(Error)
    }
    var mode: Modes = .done
    
    func getData<T: Decodable>(for fileName: String) -> Observable<T> {
        return Observable.create { observer -> Disposable in
            
        guard let url = Bundle(for: MockMLServices.self).url(forResource: fileName, withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
            XCTFail("missing mock file: \(fileName)")
            observer.onError(MLError.notFound([]))
            return Disposables.create()
        }
            observer.onNext(decodedData)
            return Disposables.create()
        }
    }
    func getError<T: Decodable>(with error: Error) -> Observable<T> {
        return Observable.create { observer -> Disposable in
            observer.onError(error)
            return Disposables.create()
        }
    }
}
