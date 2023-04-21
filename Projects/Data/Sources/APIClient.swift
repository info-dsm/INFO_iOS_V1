//
//  APIClient.swift
//  Data
//
//  Created by 박준하 on 2023/04/21.
//  Copyright © 2023 INFO-iOS. All rights reserved.
//

import Foundation
import Moya
import RxMoya
import RxSwift

public final class APIClient {
    private let provider: MoyaProvider<API>
    
    public init(provider: MoyaProvider<API> = MoyaProvider<API>()) {
        self.provider = provider
    }
    
    public func request(_ api: API) -> Single<Response> {
        return provider.rx.request(api)
    }
}
