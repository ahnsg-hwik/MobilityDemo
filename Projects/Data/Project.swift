//
//  Project.swift
//  Manifests
//
//  Created by iOS_Hwik on 12/19/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Data",
    targets: [
        .target(
            name: "Data",
            destinations: .iOS,
            product: TuistRelease.isRelease ? .staticFramework : .framework,
            bundleId: "dev.tuist.MobilityDemo.Data",
            deploymentTargets: .appMinimunTarget,
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
