// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LotteryCore",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "LotteryCore",
            targets: ["LotteryCore"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", exact: "0.58.2")
    ],
    targets: [
        .target(
            name: "LotteryCore",
            plugins: [.plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins")]
        ),
        .testTarget(
            name: "LotteryCoreTests",
            dependencies: ["LotteryCore"],
            plugins: [.plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins")]
        )
    ]
)
