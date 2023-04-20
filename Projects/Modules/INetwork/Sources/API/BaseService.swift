//
//  BaseService.swift
//  INetwork
//
//  Created by 박준하 on 2023/04/19.
//  Copyright © 2023 INFO-iOS. All rights reserved.
//

//import Foundation
//import Moya
//import RxSwift
//
//class BaseAPI<Target: TargetType> {
//    
//    typealias API = Target
//    
//    // MARK: - Properties
//    
//    private let provider: MoyaProvider<API>
//    
//    // MARK: - Initializers
//    
//    init() {
//        self.provider = MoyaProvider<API>(plugins: [NetworkLoggerPlugin()])
//    }
//    
//    // MARK: - Public methods
//    
//    func requestObject<T: Decodable>(_ target: API) -> Single<T> {
//        return provider.rx.request(target)
//            .filterSuccessfulStatusCodes()
//            .map(T.self)
//            .asSingle()
//    }
//    
//    func requestObjectWithNoResult(_ target: API) -> Single<Int> {
//        return provider.rx.request(target)
//            .filterSuccessfulStatusCodes()
//            .map { response in
//                return response.statusCode
//            }
//            .asSingle()
//    }
//}
