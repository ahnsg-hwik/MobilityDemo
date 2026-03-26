//
//  Project.swift
//  Manifests
//
//  Created by iOS_Hwik on 12/22/25.
//

import ProjectDescription

let project = Project(
    name: "Domain",
    targets: [
        .target(
            name: "Domain",
            destinations: .iOS,
            product: .framework,
//            product: .staticFramework,
            bundleId: "dev.tuist.MobilityDemo.Domain",
            deploymentTargets: .iOS("17.0"),
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
