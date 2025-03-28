// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LaunchUI",
    platforms: [.iOS(.v17), .macOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "LaunchUI",
            targets: ["LaunchUI"]),
        .library(
            name: "_LaunchPreviews",
            targets: ["LaunchPreviews"]),
    ],
    dependencies: [
        .package(name: "LaunchDefinitions", path: "../LaunchDefinitions"),
        .package(name: "RepositoryDefinitions", path: "../../Repository/RepositoryDefinitions"),
        .package(name: "SharedUI", path: "../../SharedUI/SharedUI")
    ],
    targets: [
        .target(
            name: "LaunchUI",
            dependencies: [
                .product(name: "RepositoryDefinitions", package: "RepositoryDefinitions"),
                .product(name: "LaunchDefinitions", package: "LaunchDefinitions"),
                .product(name: "SharedUI", package: "SharedUI"),
            ],
            path: "Sources/UI"
        ),
        .target(
            name: "LaunchPreviews",
            dependencies: [
                "LaunchUI",
                .product(name: "RepositoryDefinitions", package: "RepositoryDefinitions"),
                .product(name: "LaunchMocks", package: "LaunchDefinitions")
            ],
            path: "Sources/Previews"
        ),
        // Snapshot tests would go here
        //.testTarget(
        //    name: "LaunchDefinitionsTests",
        //    dependencies: [
        //        "LaunchDefinitions",
        //        "LaunchMocks"
        //    ]
        //),
    ]
)
