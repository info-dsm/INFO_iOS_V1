//
//  Dependency+Project.swift
//  MyPlugin
//
//  Created by 박준하 on 2023/04/17.
//

import ProjectDescription

public extension TargetDependency {
    public struct Project {}
}

public extension TargetDependency.Project {
    static let Presentation = TargetDependency.project(target: "Presentation", path: .relativeToRoot("Projects/Presentation"))
    
    static let Core = TargetDependency.project(target: "Core", path: .relativeToRoot("Projects/Core"))
    
    static let Data = TargetDependency.project(target: "Data", path: .relativeToRoot("Projects/Data"))
    
    static let Domain = TargetDependency.project(target: "Domain", path: .relativeToRoot("Projects/Domain"))
    
    static let ThirdPartyLib = TargetDependency.project(target: "ThirdPartyLib", path: .relativeToRoot("Projects/Modules/ThirdPartyLib"))
    
    static let Network = TargetDependency.project(target: "INetwork", path: .relativeToRoot("Projects/Modules/INetwork"))
    
    static let DSKit = TargetDependency.project(target: "INFOKit", path: .relativeToRoot("Projects/Modules/INFOKit"))
}
