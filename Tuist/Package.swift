// swift-tools-version: 6.0
import PackageDescription

#if TUIST
    import struct ProjectDescription.PackageSettings

    let packageSettings = PackageSettings(
        // Customize the product types for specific package product
        // Default is .staticFramework
        // productTypes: ["Alamofire": .framework,]
        productTypes: [
            "Moya": .framework,
            "PopupView": .framework,
            "Kingfisher": .framework,
            "NMapsMap": .framework,
            "ComposableArchitecture": .framework,
        ]
    )
#endif

let package = Package(
    name: "MobilityDemo",
    dependencies: [
        // Add your own dependencies here:
        // .package(url: "https://github.com/Alamofire/Alamofire", from: "5.0.0"),
        // You can read more about dependencies here: https://docs.tuist.io/documentation/tuist/dependencies
        .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "15.0.3")),
        .package(url: "https://github.com/exyte/PopupView.git", .upToNextMajor(from: "4.1.18")),
        .package(url: "https://github.com/onevcat/Kingfisher.git", .upToNextMajor(from: "8.6.2")),
        .package(url: "https://github.com/navermaps/SPM-NMapsMap", .upToNextMajor(from: "3.23.0")),
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", .upToNextMajor(from: "1.23.1")),
    ]
)
