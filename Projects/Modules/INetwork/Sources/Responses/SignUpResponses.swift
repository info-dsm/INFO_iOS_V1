//
//  SignUpParameters.swift
//  INetwork
//
//  Created by 박준하 on 2023/06/15.
//  Copyright © 2023 INFO-iOS. All rights reserved.
//

import Foundation

public struct SignUpResponses: Encodable {
    let studentKey: String
    let name: String
    let email: String
    let password: String
    let githubLink: String?
}
