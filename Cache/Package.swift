// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Cache",
    products: [
        .library(name: "Cache", targets: ["Cache"])
    ],
    targets: [
        .target(name: "Cache", dependencies: []),
        .testTarget(name: "CacheTests", dependencies: ["Cache"])
    ]
)
