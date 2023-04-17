//
//  ModuleFactory.swift
//  INFO-iOS
//
//  Created by 박준하 on 2023/04/17.
//  Copyright © 2023 INFO-iOS. All rights reserved.
//

import Foundation
import Presentation
import Network

public class ModuleFactory {
    static let shared = ModuleFactory()
    private init() { }
}

extension ModuleFactory: ModuleFactoryInterface {
    public func testVC() -> Presentation.ViewController {
        let vc = ViewController()
        
        return vc
    }
    
    public func makeVC() -> Presentation.ViewController {
        let vc = ViewController()
        
        return vc
    }
}
