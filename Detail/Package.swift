// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Detail",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Detail",
            targets: ["Detail"]),
    ],
    dependencies: [
        .package(
            name: "swift-composable-architecture",
            url: "https://github.com/pointfreeco/swift-composable-architecture.git",
            branch: "main")
    ],
    targets: [
        .target(
            name: "Detail",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ])
    ]
)
