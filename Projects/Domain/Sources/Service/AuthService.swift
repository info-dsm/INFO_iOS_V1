//
//  AuthService.swift
//  Domain
//
//  Created by 박준하 on 2023/04/21.
//  Copyright © 2023 INFO-iOS. All rights reserved.
//

import Foundation
import RxSwift

public protocol AuthServiceType {
    func login(user: User) -> Single<Bool>
}

public final class AuthService: AuthServiceType {
    public init() {}
    
    public func login(user: User) -> Single<Bool> {
        
        return Single.just(true)
    }
}
