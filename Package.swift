// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "mountebankSwift",
    platforms: [
            .iOS(.v16),
            .macOS(.v13),
            .tvOS(.v16),
            .watchOS(.v9)
        ],
    products: [
        .library(
            name: "mountebankSwift",
            targets: ["mountebankSwift"])
    ],
    targets: [
        .target(
            name: "mountebankSwift"),
        .testTarget(
            name: "mountebankSwiftTests",
            dependencies: ["mountebankSwift"],
            resources: [
                .copy("TestResources")
            ]
        )
    ]
)
