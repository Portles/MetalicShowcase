// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MetalicShowcase",
    platforms: [
        .iOS(.v14),
        .macOS(.v11)
    ],

    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "MetalicShowcaseHeader",
            targets: ["MetalicShowcaseHeader"]),
        .library(
            name: "MetalicShowcase",
            targets: ["MetalicShowcase"])
    ],

    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "MetalicShowcaseHeader", dependencies: [], path: "Sources/MetalicShowcaseHeader", publicHeadersPath: "include"),

        .target(name: "MetalicShowcase", dependencies: ["MetalicShowcaseHeader"], path: "Sources/MetalicShowcase", resources: [.process("Metal/")]),

        .testTarget(name: "MetalicShowcaseTests", dependencies: ["MetalicShowcase"])
    ]
)
