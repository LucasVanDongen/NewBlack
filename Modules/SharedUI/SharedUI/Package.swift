// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SharedUI",
    platforms: [.iOS(.v17), .macOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SharedUI",
            targets: ["SharedUI"]),
        .library(
            name: "_SharedUIPreviews",
            targets: ["SharedUIPreviews"]),
    ],
    dependencies: [
//        .package(name: "RocketDefinitions", path: "../RocketDefinitions"),
        .package(name: "RepositoryDefinitions", path: "../../Repository/RepositoryDefinitions")
    ],
    targets: [
        .target(
            name: "SharedUI",
            dependencies: [
                .product(name: "RepositoryDefinitions", package: "RepositoryDefinitions"),
                .product(name: "RepositoryMocks", package: "RepositoryDefinitions")
            ],
            path: "Sources/UI"
        ),
        .target(
            name: "SharedUIPreviews",
            dependencies: [
                "SharedUI"
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
