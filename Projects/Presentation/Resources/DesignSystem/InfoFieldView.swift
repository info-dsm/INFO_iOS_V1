//
//  InfoFieldView.swift
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

open class InfoFieldView: UIView {
    private let titleLabel: UILabel
    private let textField: UITextField
    
    public init(title: String) {
        titleLabel = UILabel().then {
            $0.textColor = INFOKitAsset.Colors.dailyGrayColor.color
            $0.font = .systemFont(ofSize: 15.0, weight: .semibold)
            $0.text = title
        }
        
        textField = UITextField().then {
            $0.font = .systemFont(ofSize: 10.0, weight: .medium)
            $0.tintColor = INFOKitAsset.Colors.thinGrayColor.color
            $0.attributedPlaceholder = NSAttributedString(string: "이메일을 입력해주세요", attributes: [NSAttributedString.Key.foregroundColor: INFOKitAsset.Colors.thinGrayColor.color])
            $0.keyboardType = .emailAddress
            $0.clearButtonMode = .whileEditing
            $0.borderStyle = .roundedRect
            $0.backgroundColor = INFOKitAsset.Colors.lightGrayColor.color
            $0.layer.cornerRadius = 4.0
        }
        
        super.init(frame: .zero)
        
        setupLayout()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setupLayout() {
        addSubview(titleLabel)
        addSubview(textField)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10.0)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(40.0)
        }
    }
}
