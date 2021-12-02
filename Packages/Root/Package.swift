// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "Root",
  platforms: [
    .iOS(.v15)
  ],
  products: [
    .library(name: "Root", targets: ["Root"])
  ],
  targets: [
    .target(name: "Root")
  ]
)
