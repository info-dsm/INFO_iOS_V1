//
//  LoginViewController.swift
//  Presentation
//
//  Created by 박준하 on 2023/04/19.
//  Copyright © 2023 INFO-iOS. All rights reserved.
//

import UIKit
import SnapKit
import Then
import Domain
import RxCocoa
import RxSwift
import Core
import INFOKit


public class LoginViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    public var factory: ModuleFactoryInterface!
    
    private lazy var whiteLogo = UIImageView().then {
        $0.image = INFOKitAsset.Assets.whiteLogo.image
    }

    private lazy var purpleLogo = UIImageView().then {
        $0.image = INFOKitAsset.Assets.purpleLogo.image
    }
    
    private lazy var loginBackgroundView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 30.0
    }
    
    private lazy var studentLoginTitle = UILabel().then {
        $0.text = "학생 로그인"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 36.0, weight: .bold)
    }
    
    private lazy var emailFieldView = InfoFieldView(title: "이메일")
    private lazy var passwordFieldView = InfoFieldView(title: "비밀번호")
    private lazy var loginButton = InfoCustomButton(title: "로그인", backgroundColor: INFOKitAsset.Colors.mainColor.color, titleColor: .white)
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        print("LoginViewController")
        view.backgroundColor = INFOKitAsset.Colors.mainColor.color
        layout()
    }
    
    func layout() {
        view.addSubviews([
            whiteLogo,
            loginBackgroundView,
            purpleLogo,
            studentLoginTitle,
            emailFieldView,
            passwordFieldView,
            loginButton
        ])
        
        whiteLogo.snp.makeConstraints {
            $0.top.equalToSuperview().offset(173.0)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(116.0)
            $0.height.equalTo(37.0)
        }
        
        loginBackgroundView.snp.makeConstraints {
            $0.top.equalTo(whiteLogo.snp.bottom).offset(110)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        
        purpleLogo.snp.makeConstraints {
            $0.top.equalTo(loginBackgroundView.snp.top).offset(60.0)
            $0.left.equalToSuperview().offset(50.0)
            $0.width.equalTo(58.0)
            $0.height.equalTo(20.0)
        }

        studentLoginTitle.snp.makeConstraints {
            $0.top.equalTo(purpleLogo.snp.bottom).offset(10.0)
            $0.left.equalTo(purpleLogo.snp.left)
        }
        
        emailFieldView.snp.makeConstraints { // 수정된 부분
            $0.top.equalTo(studentLoginTitle.snp.bottom).offset(64.0)
            $0.leading.trailing.equalToSuperview().inset(50.0)
            $0.height.equalTo(40.0)
        }
        
        passwordFieldView.snp.makeConstraints {
            $0.top.equalTo(emailFieldView.snp.bottom).offset(50.0)
            $0.leading.trailing.equalTo(emailFieldView)
            $0.height.equalTo(emailFieldView)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordFieldView.snp.bottom).offset(90.0)
            $0.leading.trailing.equalToSuperview().inset(50.0)
            $0.height.equalTo(48.0)
        }
    }
}
