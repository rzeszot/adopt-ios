// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "Networking",
  products: [
    .library(name: "Networking", targets: ["Networking"])
  ],
  dependencies: [
    .package(path: "Extraction/Unexpected")
  ],
  targets: [
    .target(name: "Networking", dependencies: ["Unexpected"]),
    .testTarget(name: "NetworkingTests", dependencies: ["Networking"])
  ]
)
