//
//  InfoButton.swift
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

//선 코드 수정 필요 일단은 false로 쓰자
open class InfoButton: UIButton {
    public var underlineEnabled: Bool = true {
        didSet {
            updateUnderline()
        }
    }
    
    private var underlineView: UIView?
    
    public convenience init(buttonTitle: String, underlineEnabled: Bool = true) {
        self.init(frame: .zero)
        self.underlineEnabled = underlineEnabled
        setTitle(buttonTitle, for: .normal)
        configureUI()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    open func configureUI() {
        titleLabel?.font = .systemFont(ofSize: 10.0, weight: .medium)
        setTitleColor(INFOKitAsset.Colors.dailyGrayColor.color, for: .normal)
        
        updateUnderline()
    }
    
    private func updateUnderline() {
        underlineView?.removeFromSuperview()
        
        if underlineEnabled {
            underlineView = UIView().then {
                $0.backgroundColor = INFOKitAsset.Colors.dailyGrayColor.color
            }
            addSubview(underlineView!)
            underlineView?.snp.makeConstraints {
                $0.leading.trailing.bottom.equalToSuperview()
                $0.height.equalTo(0.5)
            }
        }
    }
}
