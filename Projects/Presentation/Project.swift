//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 박준하 on 2023/04/17.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "Presentation",
    product: .staticFramework,
    dependencies: [
        .Project.Domain,
        .Project.INFOKit,
        .Project.Network,
        .Project.Data
    ],
    resources: ["Resources/**"]
)
