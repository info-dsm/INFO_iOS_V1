//
//  ModuleFactory.swift
//  INFO-iOS
//
//  Created by 박준하 on 2023/04/17.
//  Copyright © 2023 INFO-iOS. All rights reserved.
//

import Foundation
import Presentation
//import Network

public class ModuleFactory {
    public static let shared = ModuleFactory()
    private init() { }
}

extension ModuleFactory: ModuleFactoryInterface {
    public func testVC() -> Presentation.ViewController2 {
        let vc = ViewController2()
        
        return vc
    }
    
    public func makeVC() -> Presentation.ViewController2 {
        let vc = ViewController2()
        
        return vc
    }
}
