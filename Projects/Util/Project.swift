//
//  Project.swift
//  Manifests
//
//  Created by iOS_Hwik on 1/6/26.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Util",
    targets: [
        .target(
            name: "Util",
            destinations: .iOS,
            product: TuistRelease.isRelease ? .staticFramework : .framework,
            bundleId: "dev.tuist.MobilityDemo.Util",
            deploymentTargets: .appMinimunTarget,
            buildableFolders: [
                "Sources",
            ],
            dependencies: []
        ),
    ]
)
