//
//  LoginViewModel.swift
//  Presentation
//
//  Created by 박준하 on 2023/06/20.
//  Copyright © 2023 INFO-iOS. All rights reserved.
//

import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift
import Core
import INFOKit
import INetwork

class LoginViewModel {
    private let disposeBag = DisposeBag()
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func login(email: String, password: String) {
        authService.login(email: email, password: password)
            .subscribe(onSuccess: { token in
                print("성공")
            }, onFailure: { error in
                print("실패")
            })
            .disposed(by: disposeBag)
    }
}
