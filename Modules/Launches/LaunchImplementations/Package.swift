// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LaunchImplementations",
    platforms: [.iOS(.v17), .macOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "LaunchImplementations",
            targets: ["LaunchImplementations"]
        )
    ],
    dependencies: [
        .package(name: "LaunchDefinitions", path: "../LaunchDefinitions"),
        .package(name: "RepositoryDefinitions", path: "../../Repository/RepositoryDefinitions")
    ],
    targets: [
        .target(
            name: "LaunchImplementations",
            dependencies: [
                .product(name: "LaunchDefinitions", package: "LaunchDefinitions"),
                .product(name: "RepositoryDefinitions", package: "RepositoryDefinitions")
            ],
            path: "Sources/Implementations"
        ),
        .testTarget(
            name: "LaunchTests",
            dependencies: [
                .product(name: "LaunchDefinitions", package: "LaunchDefinitions"),
                .product(name: "LaunchMocks", package: "LaunchDefinitions")
            ]
        ),
    ]
)
