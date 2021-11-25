// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "Process",
  platforms: [
    .iOS(.v15),
    .macOS(.v12)
  ],
  products: [
    .library(name: "Process", targets: ["Process"])
  ],
  targets: [
    .target(name: "Process", dependencies: []),
    .testTarget(name: "ProcessTests", dependencies: ["Process"])
  ]
)
