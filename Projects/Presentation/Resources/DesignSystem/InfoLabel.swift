//
//  InfoLabel.swift
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

open class InfoLabel: UILabel {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    open func configureUI() {
        font = .systemFont(ofSize: 10.0, weight: .medium)
        textColor = INFOKitAsset.Colors.dailyGrayColor.color
    }
    
    public convenience init(title: String) {
        self.init(frame: .zero)
        text = title
    }
}
