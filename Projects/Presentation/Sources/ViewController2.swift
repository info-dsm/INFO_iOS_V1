//
//  ViewController.swift
//  Presentation
//
//  Created by 박준하 on 2023/04/17.
//  Copyright © 2023 INFO-iOS. All rights reserved.
//

import UIKit
import SnapKit
import Then

public class ViewController2: UIViewController {
   
    var button = UIButton().then {
        $0.backgroundColor = .green
    }
    
    public var factory: ModuleFactoryInterface!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        view.addSubview(button)
        
        button.snp.makeConstraints {
            $0.height.width.equalTo(100)
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
