// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "RepositoryDefinitions",
    platforms: [.iOS(.v17), .macOS(.v15)],
    products: [
        .library(name: "RepositoryDefinitions", targets: ["RepositoryDefinitions"]),
        .library(name: "RepositoryMocks", targets: ["RepositoryMocks"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "RepositoryDefinitions",
            dependencies: [],
            path: "Sources/Definitions"
        ),
        .target(
            name: "RepositoryMocks",
            dependencies: ["RepositoryDefinitions"],
            path: "Sources/Mocks"
        )
    ]
)
