// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription



let package = Package.init(
    name: "Blue Husky Canvas",
    platforms: [.macOS(.v10_15)],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "BlueHuskyCanvas",
            targets: ["BlueHuskyCanvas"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/RougeWare/Swift-Color-Swatches.git", .branch("feature/MVP")),
        .package(url: "https://github.com/RougeWare/Swift-Rectangle-Tools.git", from: "2.4.0"),
        .package(url: "https://github.com/RougeWare/Swift-Cross-Kit-Types.git", from: "1.0.0"),
        .package(url: "https://github.com/RougeWare/Swift-Function-Tools.git", from: "1.2.2"),
        .package(url: "https://github.com/pointfreeco/swift-nonempty.git", from: "0.2.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "BlueHuskyCanvas",
            dependencies: ["ColorSwatches", "CrossKitTypes", "FunctionTools", "RectangleTools", "NonEmpty"]),
        .testTarget(
            name: "BlueHuskyCanvasTests",
            dependencies: ["BlueHuskyCanvas"]),
    ]
)
