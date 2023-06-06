//
//  AuthAPI.swift
//  Data
//
//  Created by 박준하 on 2023/05/03.
//  Copyright © 2023 INFO-iOS. All rights reserved.
//

import Foundation
import Moya
import Core
import RxMoya
import RxSwift
import RxCocoa

public enum AuthAPI {
    case login(email: String, password: String)
    case sandCode(email: String)
    case checkCode(email: String, data: String, type: String)
    case signup(emailCode: String, parameters: SignUpParameters)
    case reissue
    case tokenTime(token: String)
    case resetPassword(PasswordResetRequest)
}

extension AuthAPI: TargetType {
    public var baseURL: URL {
        return URL.baseURL
    }
    
    public var path: String {
        switch self {
        case .login:
            return "/auth/login/user"
        case .sandCode(let email):
            return "/auth/code?email=\(email)"
        case .checkCode:
            return "/auth/code"
        case .signup(let emailCode, _):
            return "/auth/signup/student?emailCode=\(emailCode)"
        case .reissue:
            return "/auth/reissue"
        case .tokenTime:
            return "/auth/token"
        case .resetPassword:
            return "/auth/password"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .login:
            return .post
        case .sandCode:
            return .put
        case .checkCode:
            return .post
        case .signup:
            return .post
        case .reissue:
            return .put
        case .tokenTime:
            return .get
        case .resetPassword:
            return .put
        }
    }
    
    public var task: Task {
        switch self {
        case let .login(email, password):
            let parameters = ["email": email, "password": password]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .sandCode:
            return .requestPlain
        case let .checkCode(email, data, type):
            let parameters = ["email": email, "data": data, "type": type]
             return .requestJSONEncodable(parameters)
        case let .signup(_, parameters):
            return .requestJSONEncodable(parameters)
        case .reissue:
             return .requestPlain
        case .tokenTime(let token):
            let parameters: [String : Any] = ["token": token]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .resetPassword(let request):
            return .requestJSONEncodable(request)
        }
    }
    
    public var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
