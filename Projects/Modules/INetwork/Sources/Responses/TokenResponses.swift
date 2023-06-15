//
//  TokenResponses.swift
//  INetwork
//
//  Created by 박준하 on 2023/06/15.
//  Copyright © 2023 INFO-iOS. All rights reserved.
//

import Foundation

public struct Token: Codable {
    let accessToken: String
    let refreshToken: String
}
