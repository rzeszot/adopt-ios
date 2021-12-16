// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "Routing",
  products: [
    .library(name: "Routing", targets: ["Routing"]),
  ],
  targets: [
    .target(name: "Routing", dependencies: []),
    .testTarget(name: "RoutingTests", dependencies: ["Routing"]),
  ]
)
