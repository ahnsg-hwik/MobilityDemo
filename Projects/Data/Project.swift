//
//  Project.swift
//  Manifests
//
//  Created by iOS_Hwik on 12/19/25.
//

import ProjectDescription

let project = Project(
    name: "Data",
    targets: [
        .target(
            name: "Data",
            destinations: .iOS,
            product: .framework,
//            product: .staticFramework,
            bundleId: "dev.tuist.MobilityDemo.Data",
            deploymentTargets: .iOS("16.0"),
            buildableFolders: [
                "Sources",
            ],
            dependencies: [
                .external(name: "Moya"),
                .project(target: "Domain", path: .relativeToRoot("Projects/Domain")),
            ]
        ),
    ]
)
