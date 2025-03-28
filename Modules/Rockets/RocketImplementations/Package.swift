// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RocketImplementations",
    platforms: [.iOS(.v17), .macOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "RocketImplementations",
            targets: ["RocketImplementations"]
        )
    ],
    dependencies: [
        .package(name: "RocketDefinitions", path: "../RocketDefinitions"),
        .package(name: "RepositoryDefinitions", path: "../../Repository/RepositoryDefinitions")
    ],
    targets: [
        .target(
            name: "RocketImplementations",
            dependencies: [
                .product(name: "RocketDefinitions", package: "RocketDefinitions"),
                .product(name: "RepositoryDefinitions", package: "RepositoryDefinitions")
            ],
            path: "Sources/Implementations"
        ),
        .testTarget(
            name: "RocketTests",
            dependencies: [
                .product(name: "RocketDefinitions", package: "RocketDefinitions"),
                .product(name: "RocketMocks", package: "RocketDefinitions")
            ]
        ),
    ]
)
