//
//  LoginViewModel.swift
//  Presentation
//
//  Created by 박준하 on 2023/04/19.
//  Copyright © 2023 INFO-iOS. All rights reserved.
//

import RxSwift

class LoginViewModel {
    private let disposeBag = DisposeBag()

    let email = BehaviorSubject<String>(value: "")
    let password = BehaviorSubject<String>(value: "")
    let isLoading = BehaviorSubject<Bool>(value: false)
    let error = BehaviorSubject<String?>(value: nil)

    func login() {
        guard let email = try? email.value(),
            let password = try? password.value() else {
            return
        }

        isLoading.onNext(true)
        Provider.shared.login(email: email, password: password)
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] _ in
                self?.isLoading.onNext(false)
            }, onError: { [weak self] error in
                self?.isLoading.onNext(false)
                self?.error.onNext(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
}
