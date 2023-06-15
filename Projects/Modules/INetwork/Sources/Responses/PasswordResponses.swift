//
//  PasswordResponses.swift
//  INetwork
//
//  Created by 박준하 on 2023/06/15.
//  Copyright © 2023 INFO-iOS. All rights reserved.
//

import Foundation

public struct PasswordResponses: Codable {
    let email: String
    let code: String
    let newPassword: String
}
