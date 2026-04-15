//
//  Project.swift
//  Manifests
//
//  Created by iOS_Hwik on 12/22/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Domain",
    targets: [
        .target(
            name: "Domain",
            destinations: .iOS,
            product: TuistRelease.isRelease ? .staticFramework : .framework,
            bundleId: "dev.tuist.MobilityDemo.Domain",
            deploymentTargets: .appMinimunTarget,
            buildableFolders: [
                "Sources",
            ],
            dependencies: [
                // Feature, Data layer는 Domina layer를 의존하고 있어 자동 ComposableArchitecture 의존
                // - 만약 Feature, Data layer 에서 ComposableArchitecture를 중복 의존 하면 경고 발생
                .external(name: "ComposableArchitecture"),
            ]
        ),
    ]
)
