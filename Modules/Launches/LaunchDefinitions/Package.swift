// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LaunchDefinitions",
    platforms: [.iOS(.v17), .macOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "LaunchDefinitions",
            targets: ["LaunchDefinitions"]),
        .library(
            name: "LaunchMocks",
            targets: ["LaunchMocks"]),
    ],
    dependencies: [
        .package(name: "RepositoryDefinitions", path: "../../Repository/RepositoryDefinitions"),
        .package(name: "RocketDefinitions", path: "../../Rocket/RocketDefinitions")
    ],
    targets: [
        .target(
            name: "LaunchDefinitions",
            dependencies: [
                .product(name: "RepositoryDefinitions", package: "RepositoryDefinitions"),
                .product(name: "RocketDefinitions", package: "RocketDefinitions")
            ],
            path: "Sources/Definitions"
        ),
        .target(
            name: "LaunchMocks",
            dependencies: ["LaunchDefinitions"],
            path: "Sources/Mocks"
        ),
        .testTarget(
            name: "LaunchDefinitionsTests",
            dependencies: [
                "LaunchDefinitions",
                "LaunchMocks"
            ]
        ),
    ]
)
