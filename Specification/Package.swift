// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Specification",
    products: [
        .library(
            name: "Specification", targets: ["Specification"])
    ],
    targets: [
        .target(name: "Specification", dependencies: []),
        .testTarget(name: "SpecificationTests", dependencies: ["Specification"])
    ]
)
