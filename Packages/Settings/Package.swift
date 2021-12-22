// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "Settings",
  platforms: [
    .iOS(.v15)
  ],
  products: [
    .library(name: "Settings", targets: ["Settings"])
  ],
  targets: [
    .target(name: "Settings")
  ]
)
