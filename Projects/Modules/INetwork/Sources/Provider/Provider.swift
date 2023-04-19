//
//  Provider.swift
//  INetwork
//
//  Created by 박준하 on 2023/04/19.
//  Copyright © 2023 INFO-iOS. All rights reserved.
//

import Moya
import RxMoya
import RxSwift

open class Provider {
    static let shared = Provider()
    private let provider = MoyaProvider<API>()
    private let disposeBag = DisposeBag()
    
    func login(email: String, password: String) -> Single<Bool> {
        return provider.rx.request(.login(email: email, password: password))
            .map { response in
                return true
            }
            .catchError { error in
                return Single.error(error)
            }
    }
}
