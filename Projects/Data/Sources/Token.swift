//
//  Token.swift
//  Data
//
//  Created by 박준하 on 2023/05/03.
//  Copyright © 2023 INFO-iOS. All rights reserved.
//

import Foundation

struct Token: Codable {
    let accessToken: String
    let refreshToken: String
}
