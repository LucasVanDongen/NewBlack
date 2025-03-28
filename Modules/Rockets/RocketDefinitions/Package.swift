// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RocketDefinitions",
    platforms: [.iOS(.v17), .macOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "RocketDefinitions",
            targets: ["RocketDefinitions"]),
        .library(
            name: "RocketMocks",
            targets: ["RocketMocks"]),
    ],
    dependencies: [
        .package(name: "RepositoryDefinitions", path: "../../Repository/RepositoryDefinitions")

    ],
    targets: [
        .target(
            name: "RocketDefinitions",
            dependencies: [.product(name: "RepositoryDefinitions", package: "RepositoryDefinitions")],
            path: "Sources/Definitions"
        ),
        .target(
            name: "RocketMocks",
            dependencies: ["RocketDefinitions"],
            path: "Sources/Mocks"
        ),
        .testTarget(
            name: "RocketDefinitionsTests",
            dependencies: [
                "RocketDefinitions",
                "RocketMocks"
            ]
        ),
    ]
)
