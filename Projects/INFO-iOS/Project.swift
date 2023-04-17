//
//  Project.swiftb
//  ProjectDescriptionHelpers
//
//  Created by 박준하 on 2023/04/17.
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.makeModule(
    name: "INFO-iOS",
    platform: .iOS,
    product: .app,
    dependencies: [
        .Project.Data,
        .Project.Presentation
    ],
    resources: ["Resources/**"],
    infoPlist: .extendingDefault(with: Project.baseinfoPlist)

)
