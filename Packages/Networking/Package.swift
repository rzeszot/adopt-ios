// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "Networking",
  products: [
    .library(name: "Networking", targets: ["Networking"])
  ],
  targets: [
    .target(name: "Networking", dependencies: []),
    .testTarget(name: "NetworkingTests", dependencies: ["Networking"])
  ]
)
