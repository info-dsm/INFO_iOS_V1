//
//  AuthService.swift
//  Data
//
//  Created by 박준하 on 2023/05/03.
//  Copyright © 2023 INFO-iOS. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxMoya

class AuthService {
    let provider = MoyaProvider<AuthAPI>()
    
    func login(email: String, password: String) -> Single<Token> {
        return provider.rx
            .request(.login(email: email, password: password))
            .filterSuccessfulStatusCodes()
            .map(Token.self)
    }
    
    func sendCode(email: String) -> Single<Void> {
        return provider.rx
            .request(.sandCode(email: email))
            .filterSuccessfulStatusCodes()
            .map { _ in Void() }
    }
    
    func checkCode(email: String, data: String, type: String) -> Single<Void> {
        return provider.rx
            .request(.checkCode(email: email, data: data, type: type))
            .filterSuccessfulStatusCodes()
            .map { _ in }
    }
    
    func signUp(emailCode: String, studentKey: String, name: String, email: String, password: String, githubLink: String?) -> Single<Void> {
        let signUpParameters = SignUpParameters(studentKey: studentKey, name: name, email: email, password: password, githubLink: githubLink)
        return provider.rx
            .request(.signup(emailCode: emailCode, parameters: signUpParameters))
            .filterSuccessfulStatusCodes()
            .map { _ in Void() }
    }
}
