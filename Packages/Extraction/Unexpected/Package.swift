// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "SharedKernel",
  products: [
    .library(name: "Unexpected", targets: ["Unexpected"])
  ],
  targets: [
    .target(name: "Unexpected", dependencies: []),
    .testTarget(name: "UnexpectedTests", dependencies: ["Unexpected"])
  ]
)
