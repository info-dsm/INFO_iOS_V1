//
//  LoginAPI.swift
//  INetwork
//
//  Created by 박준하 on 2023/04/19.
//  Copyright © 2023 INFO-iOS. All rights reserved.
//

import RxSwift
import RxCocoa
import UIKit
import Alamofire
import Moya

enum API {
    case login(email: String, password: String)
}

extension API: TargetType {
    var baseURL: URL { return URL(string: "https://api.info-dsm.info")! }
    
    var path: String {
        switch self {
        case .login:
            return "/auth/login/user"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case let .login(email, password):
            return .requestParameters(parameters: ["email": email, "password": password], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
