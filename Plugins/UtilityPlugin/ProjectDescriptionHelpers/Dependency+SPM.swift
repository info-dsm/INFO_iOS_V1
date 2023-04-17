//
//  Dependency+SPM.swift
//  MyPlugin
//
//  Created by 박준하 on 2023/04/17.
//

import ProjectDescription

public extension TargetDependency {
    enum SPM {}
}

public extension TargetDependency.SPM {
    static let SnapKit = TargetDependency.external(name: "SnapKit")
    static let Then = TargetDependency.external(name: "Then")
    static let Kingfisher = TargetDependency.external(name: "Kingfisher")
    static let Moya = TargetDependency.external(name: "Moya")
    static let AWSCore = TargetDependency.external(name: "AWSCore")
    static let AWSSNS = TargetDependency.external(name: "AWSSNS")
}
