//
//  SignupViewController.swift
//  Presentation
//
//  Created by 박준하 on 2023/06/05.
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

public class SignupViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    public var factory: ModuleFactoryInterface!
    
    private lazy var purpleLogo = UIImageView().then {
        $0.image = INFOKitAsset.Assets.purpleLogo.image
    }
    
    private lazy var studentLoginTitle = UILabel().then {
        $0.text = "학생 회원가입"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 36.0, weight: .bold)
    }
    
    private lazy var gmailFieldView = InfoTwoFieldView(title: "이메일")
    private lazy var studentIdFieldView1 = InfoTwoFieldView(title: "이름 · 학번")
    private lazy var studentIdFieldView2 = InfoTwoFieldView(title: "이름 · 학번")
    private lazy var githubFieldView = InfoOneFieldView(title: "깃허브 주소")
    private lazy var signupButton = InfoCustomButton(title: "회원가입", backgroundColor: INFOKitAsset.Colors.mainColor.color, titleColor: .white)
    
    private lazy var userInfoStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4.0
        $0.addArrangedSubview(InfoLabel(title: "info 기존 회원이신가요?"))
        $0.addArrangedSubview(InfoButton(buttonTitle: "로그인", underlineEnabled: false, titleColor: INFOKitAsset.Colors.mainColor.color))
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        layout()
    }
    
    func layout() {
        view.addSubviews([
            purpleLogo,
            studentLoginTitle,
            gmailFieldView,
            studentIdFieldView1,
            studentIdFieldView2,
            githubFieldView,
            signupButton,
            userInfoStackView
        ])
        
        purpleLogo.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(50.0)
            $0.left.equalToSuperview().offset(50.0)
            $0.width.equalTo(58.0)
            $0.height.equalTo(20.0)
        }

        studentLoginTitle.snp.makeConstraints {
            $0.top.equalTo(purpleLogo.snp.bottom).offset(10.0)
            $0.left.equalTo(purpleLogo.snp.left)
        }
        
        gmailFieldView.snp.makeConstraints {
            $0.top.equalTo(studentLoginTitle.snp.bottom).offset(14.0)
            $0.leading.trailing.equalToSuperview().inset(50.0)
            $0.height.equalTo(40.0)
        }
        
        studentIdFieldView1.snp.makeConstraints {
            $0.top.equalTo(gmailFieldView.snp.bottom).offset(100.0)
            $0.leading.trailing.equalToSuperview().inset(50.0)
            $0.height.equalTo(40.0)
        }
        
        studentIdFieldView2.snp.makeConstraints {
            $0.top.equalTo(studentIdFieldView1.snp.bottom).offset(100.0)
            $0.leading.trailing.equalToSuperview().inset(50.0)
            $0.height.equalTo(40.0)
        }
        
        githubFieldView.snp.makeConstraints {
            $0.top.equalTo(studentIdFieldView2.snp.bottom).offset(100.0)
            $0.leading.trailing.equalToSuperview().inset(50.0)
            $0.height.equalTo(40.0)
        }
        
        signupButton.snp.makeConstraints {
            $0.top.equalTo(githubFieldView.snp.bottom).offset(80.0)
            $0.leading.trailing.equalToSuperview().inset(50.0)
            $0.height.equalTo(40.0)
        }
        
        userInfoStackView.snp.makeConstraints {
            $0.top.equalTo(signupButton.snp.bottom).offset(14.0)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(100.0)
        }
    }
}
