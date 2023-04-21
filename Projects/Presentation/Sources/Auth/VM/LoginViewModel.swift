//
//  LoginViewModel.swift
//  Presentation
//
//  Created by 박준하 on 2023/04/21.
//  Copyright © 2023 INFO-iOS. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Domain

final class LoginViewModel {
    private let authService: AuthServiceType
    private let disposeBag = DisposeBag()
    
    init(authService: AuthServiceType) {
        self.authService = authService
    }
    
    func login(username: String, password: String) -> Observable<Bool> {
        let user = User(username: username, password: password)
        return authService.login(user: user)
            .asObservable()
            .catchErrorJustReturn(false)
    }
}
