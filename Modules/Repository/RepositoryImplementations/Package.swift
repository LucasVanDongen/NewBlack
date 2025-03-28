// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "RepositoryImplementations",
    platforms: [.iOS(.v17), .macOS(.v15)],
    products: [
        .library(name: "RepositoryImplementations", targets: ["RepositoryImplementations"])
    ],
    dependencies: [
        .package(name: "RepositoryDefinitions", path: "../RepositoryDefinitions")
    ],
    targets: [
        .target(
            name: "RepositoryImplementations",
            dependencies: [
                .product(name: "RepositoryDefinitions", package: "RepositoryDefinitions")
            ],
            path: "Sources/Implementations"
        ),
        .testTarget(
            name: "RepositoryTests",
            dependencies: [
                .product(name: "RepositoryMocks", package: "RepositoryDefinitions"),
                .product(name: "RepositoryDefinitions", package: "RepositoryDefinitions"),
                .targetItem(name: "RepositoryImplementations", condition: .none)
            ],
            path: "Tests"
        )
    ]
)
