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

public class LoginViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    public var factory: ModuleFactoryInterface!
        
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
    }
    
}
