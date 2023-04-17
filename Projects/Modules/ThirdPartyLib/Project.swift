//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 박준하 on 2023/04/17.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "ThirdPartyLib",
    product: .framework,
    packages: [],
    dependencies: [
        .SPM.SnapKit,
        .SPM.Kingfisher,
        .SPM.Then,
        .SPM.Moya,
        .SPM.AWSCore,
        .SPM.AWSSNS
    ]
)
