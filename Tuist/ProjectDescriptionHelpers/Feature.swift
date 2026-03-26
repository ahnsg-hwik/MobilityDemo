//
//  Feature.swift
//  Manifests
//
//  Created by iOS_Hwik on 12/26/25.
//

import ProjectDescription
import Foundation

public enum Feature: String, CaseIterable {
    case main = "Main"
    case setting = "Setting"
    
    public var target: Target {
        return .target(
            name: "\(self.rawValue)",
            destinations: .iOS,
            product: .framework,
//            product: .staticFramework,
            bundleId: "dev.tuist.MobilityDemo.\(self.rawValue)",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .file(path: .relativeToRoot("Projects/App/Resources/MobilityDemo-Info.plist")),
            buildableFolders: [
                .folder("\(self.rawValue)/Sources"),
            ],
            dependencies: self.dependencies + [
                .project(target: "DSKit", path: .relativeToRoot("Projects/DSKit")),
                .project(target: "Domain", path: .relativeToRoot("Projects/Domain")),
            ]
        )
    }
    
    public var demoTarget: Target {
        var dependencies: [TargetDependency] = [.target(self.target)]
        
        return .target(
            name: "\(self.rawValue)Demo",
            destinations: .iOS,
            product: .app,
            bundleId: "dev.tuist.MobilityDemo.\(self.rawValue)Demo",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .file(path: .relativeToRoot("Projects/App/Resources/MobilityDemo-Info.plist")),
            buildableFolders: [
                .folder("\(self.rawValue)Demo/Sources"),
            ],
            dependencies: dependencies
        )
    }
    
    public var dependencies: [TargetDependency] {
        switch self {
        case .main:
            return [
                .external(name: "NMapsMap"),
                .project(target: "Setting", path: .relativeToRoot("Projects/Feature")),
            ]
        case .setting: return []
        }
    }
}
