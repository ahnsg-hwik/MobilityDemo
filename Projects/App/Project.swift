import ProjectDescription
import ProjectDescriptionHelpers

let features: [TargetDependency] = Feature.allCases.map { feature in
    .project(target: "\(feature.rawValue)", path: .relativeToRoot("Projects/Feature"))
}

let project = Project(
    name: "MobilityDemo",
    options: .options(
        defaultKnownRegions: ["en", "ko"],
        developmentRegion: "ko"
    ),
    targets: [
        .target(
            name: "MobilityDemo",
            destinations: .iOS,
            product: .app,
            bundleId: "dev.tuist.MobilityDemo.tag",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .file(path: .relativeToRoot("Projects/App/Resources/MobilityDemo-Info.plist")),
            buildableFolders: [
                "Sources",
                "Resources",
            ],
            dependencies: features + [
                .project(target: "Data", path: .relativeToRoot("Projects/Data")),
            ],
            settings: .settings(
                base: [
                    "CODE_SIGN_STYLE": "Automatic",
                    "DEVELOPMENT_TEAM": "FNAX7R3FLJ",
                ],
//                configurations: [
//                    .debug(name: .debug, settings: [:], xcconfig: nil),
//                    .release(name: .release, settings: [:], xcconfig: nil)
//                ]
            )
        ),
        .target(
            name: "MobilityDemoTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "dev.tuist.MobilityDemoTests",
            infoPlist: .file(path: .relativeToRoot("Projects/App/Resources/MobilityDemoTests-Info.plist")),
            buildableFolders: [
                "Tests"
            ],
            dependencies: [.target(name: "MobilityDemo")]
        ),
    ]
)
