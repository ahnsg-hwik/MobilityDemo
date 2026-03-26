import ProjectDescription
import ProjectDescriptionHelpers

let targets = Feature.allCases.map { feature in
    return feature.target
}

let demoTargets = Feature.allCases.map { feature in
    return feature.demoTarget
}

let project = Project (
    name: "Feature",
    options: .options(
        defaultKnownRegions: ["en", "ko"],
        developmentRegion: "ko"
    ),
    targets: targets + demoTargets
)
