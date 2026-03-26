//
//  Project.swift
//  Manifests
//
//  Created by iOS_Hwik on 1/6/26.
//

import ProjectDescription

let project = Project(
    name: "DSKit",
    options: .options(
        defaultKnownRegions: ["en", "ko"],
        developmentRegion: "ko"
    ),
    targets: [
        .target(
            name: "DSKit",
            destinations: .iOS,
            product: .framework,
//            product: .staticFramework,
            bundleId: "dev.tuist.MobilityDemo.DSKit",
            deploymentTargets: .iOS("16.0"),
            buildableFolders: [
                "Sources",
                "Resources",
            ],
            dependencies: [
                .external(name: "PopupView"),
                .external(name: "Kingfisher"),
                .project(target: "Util", path: .relativeToRoot("Projects/Util")),
            ]
        ),
    ]
)
