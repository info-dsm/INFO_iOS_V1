//
//  UserModel.swift
//  Domain
//
//  Created by 박준하 on 2023/04/21.
//  Copyright © 2023 INFO-iOS. All rights reserved.
//

import Foundation

public struct User {
    public let username: String
    public let password: String

    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}
