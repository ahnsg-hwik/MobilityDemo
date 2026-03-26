//
//  Project.swift
//  Manifests
//
//  Created by iOS_Hwik on 1/6/26.
//

import ProjectDescription

let project = Project(
    name: "Util",
    targets: [
        .target(
            name: "Util",
            destinations: .iOS,
            product: .framework,
//            product: .staticFramework,
            bundleId: "dev.tuist.MobilityDemo.Util",
            deploymentTargets: .iOS("16.0"),
            buildableFolders: [
                "Sources",
            ],
            dependencies: []
        ),
    ]
)
