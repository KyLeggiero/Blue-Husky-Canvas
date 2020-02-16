// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription



private let sharedHumanReadableName = "Blue Husky Canvas"



private let sharedProducts: [Product] = [
    // Products define the executables and libraries produced by a package, and make them visible to other packages.
    .library(
        name: "BlueHuskyCanvas",
        targets: ["BlueHuskyCanvas"]),
]


private let sharedDependencies: [Package.Dependency] = [
    // Dependencies declare other packages that this package depends on.
    .package(url: "https://github.com/RougeWare/Swift-Rectangle-Tools.git", from: "1.0.0"),
    .package(url: "https://github.com/RougeWare/Swift-Cross-Kit-Types.git", from: "1.0.0"),
    .package(url: "https://github.com/pointfreeco/swift-nonempty.git", from: "0.2.0"),
]



let macOSPackage = Package(
    name: "\(sharedHumanReadableName) for macOS",
    platforms: [.macOS(.v10_10)],
    products: sharedProducts,
    dependencies: sharedDependencies,
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "BlueHuskyCanvas",
            dependencies: ["RectangleTools", "CrossKitTypes", "NonEmpty"]),
        .testTarget(
            name: "BlueHuskyCanvasTests",
            dependencies: ["BlueHuskyCanvas"]),
    ]
)



let iOSPackage = Package(
    name: "\(sharedHumanReadableName) for iOS",
    platforms: [.iOS(.v8)],
    products: sharedProducts,
    dependencies: sharedDependencies,
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "BlueHuskyCanvas",
            dependencies: ["RectangleTools", "CrossKitTypes", "NonEmpty"]),
        .testTarget(
            name: "BlueHuskyCanvasTests",
            dependencies: ["BlueHuskyCanvas"]),
    ]
)
