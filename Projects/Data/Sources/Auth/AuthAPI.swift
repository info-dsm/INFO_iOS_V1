//
//  AuthAPI.swift
//  Data
//
//  Created by 박준하 on 2023/05/03.
//  Copyright © 2023 INFO-iOS. All rights reserved.
//

import Foundation
import Moya
import Domain
import Core

public enum AuthAPI {
    case login(email: String, password: String)
}

extension AuthAPI: TargetType {
    public var baseURL: URL {
        return URL.baseURL
    }
    
    public var path: String {
        switch self {
        case .login:
            return "/auth/login/user"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }
    
    public var task: Task {
        switch self {
        case let .login(email, password):
            let parameters = ["email": email, "password": password]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    
    public var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
