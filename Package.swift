// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PlanA",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/vapor/vapor.git", .revision("d82adc920c4349d927c27ceca44db779ab3da51d")),
        .package(url: "https://github.com/OpenKitten/Meow.git", .revision("0.0.20170720"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "PlanA",
            dependencies: ["Vapor"]),
    ]
)
