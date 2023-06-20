//
//  AuthEntities.swift
//  Domain
//
//  Created by 박준하 on 2023/06/19.
//  Copyright © 2023 INFO-iOS. All rights reserved.
//

import UIKit
import INetwork

public struct AuthEntities {
    let token: Token
    let username: String
    let email: String
    
    init(token: Token, username: String, email: String) {
        self.token = token
        self.username = username
        self.email = email
    }
}
