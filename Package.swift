// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DBSphereTagCloudSwift",
    platforms: [.iOS(.v8)],
    products: [
        .library(
            name: "DBSphereTagCloudSwift",
            targets: ["DBSphereTagCloudSwift"]),
    ],
    dependencies: [
        .package(url: "https://github.com/donald-pinckney/SwiftNum", .upToNextMajor(from: "1.9.9"))
    ],
    targets: [
        .target(
            name: "DBSphereTagCloudSwift",
            dependencies: ["SwiftNum"]),
    ]
)
