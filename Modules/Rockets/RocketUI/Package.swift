// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RocketUI",
    platforms: [.iOS(.v17), .macOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "RocketUI",
            targets: ["RocketUI"]),
        .library(
            name: "_RocketPreviews",
            targets: ["RocketPreviews"]),
    ],
    dependencies: [
        .package(name: "RocketDefinitions", path: "../RocketDefinitions"),
        .package(name: "RepositoryDefinitions", path: "../../Repository/RepositoryDefinitions"),
        .package(name: "SharedUI", path: "../../SharedUI/SharedUI")
    ],
    targets: [
        .target(
            name: "RocketUI",
            dependencies: [
                .product(name: "RepositoryDefinitions", package: "RepositoryDefinitions"),
                .product(name: "RocketDefinitions", package: "RocketDefinitions"),
                .product(name: "SharedUI", package: "SharedUI"),
            ],
            path: "Sources/UI"
        ),
        .target(
            name: "RocketPreviews",
            dependencies: [
                "RocketUI",
                .product(name: "RepositoryDefinitions", package: "RepositoryDefinitions"),
                .product(name: "RocketMocks", package: "RocketDefinitions")
            ],
            path: "Sources/Previews"
        ),
        // Snapshot tests would go here
        //.testTarget(
        //    name: "RocketDefinitionsTests",
        //    dependencies: [
        //        "RocketDefinitions",
        //        "RocketMocks"
        //    ]
        //),
    ]
)
