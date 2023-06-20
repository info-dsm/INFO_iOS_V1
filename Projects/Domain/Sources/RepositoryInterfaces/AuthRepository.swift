//
//  AuthRepository.swift
//  Domain
//
//  Created by 박준하 on 2023/06/19.
//  Copyright © 2023 INFO-iOS. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public protocol AuthRepository {
    func login(username: String, password: String, completion: @escaping (Result<AuthEntities, Error>) -> Void)
    func sendCode(email: String, completion: @escaping (Result<Void, Error>) -> Void)
    func checkCode(code: String, completion: @escaping (Result<Void, Error>) -> Void)
    func signUp(username: String, password: String, email: String, completion: @escaping (Result<AuthEntities, Error>) -> Void)
}
