//
//  PasswordResetRequest.swift
//  Data
//
//  Created by 박준하 on 2023/05/03.
//  Copyright © 2023 INFO-iOS. All rights reserved.
//
import Foundation

public struct PasswordResetRequest: Codable {
    let email: String
    let code: String
    let newPassword: String
}
