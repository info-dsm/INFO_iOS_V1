//
//  API.swift
//  Data
//
//  Created by 박준하 on 2023/04/21.
//  Copyright © 2023 INFO-iOS. All rights reserved.
//

// API.swift

import Foundation
import Moya
import Domain

public enum API {
    case login(User)
}

extension API: TargetType {
    public var baseURL: URL {
        return URL(string: "https://api.info-dsm.info")!
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
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case let .login(user):
            let parameters = ["username": user.username, "password": user.password]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    
    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
