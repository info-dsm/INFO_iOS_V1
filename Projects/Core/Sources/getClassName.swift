//
//  getClassName.swift
//  Core
//
//  Created by 박준하 on 2023/04/17.
//  Copyright © 2023 INFO-iOS. All rights reserved.
//

import UIKit

extension NSObject {
    public static var className: String {
        NSStringFromClass(self.classForCoder()).components(separatedBy: ".").last!
    }
    
    public var className: String {
        NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
    }
}
