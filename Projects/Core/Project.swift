//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 박준하 on 2023/04/17.
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.makeModule(
    name: "Core",
    product: .staticFramework,
    dependencies: [
        .Project.ThirdPartyLib
    ]
)
