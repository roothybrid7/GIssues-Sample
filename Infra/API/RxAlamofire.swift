//
//  RxAlamofire.swift
//  Infra
//
//  Created by SATOSHI OKI on 12/19/18.
//

import Foundation
import Alamofire
import RxSwift

extension DataRequest {

    public func responseObjectForObservation<T: Decodable>(inResponseQueue queue: DispatchQueue? = nil, converter: @escaping (_ response: HTTPURLResponse, _ data: Data) throws -> T) -> Single<T> {

        return Single.create { observer -> Disposable in

            self.validate().response(queue: queue) { response in
                guard let httpURLResponse = response.response else {
                    observer(.error(NetworkError.unresolved))
                    return
                }
                if let error = response.error {
                    observer(.error(error))
                    return
                }
                guard let data = response.data else {
                    observer(.error(NetworkError.unresolved))
                    return
                }

                do {
                    let object = try converter(httpURLResponse, data)
                    observer(.success(object))
                } catch {
                    observer(.error(error))
                }
            }

            return Disposables.create {
                self.cancel()
            }
        }
    }
}
