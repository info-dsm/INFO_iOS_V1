//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 박준하 on 2023/04/17.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "INFOKit",
    product: .staticFramework,
    dependencies: [
        .Project.Core
    ],
    resources: ["Resources/**"]
)
