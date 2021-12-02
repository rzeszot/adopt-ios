// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "User",
  platforms: [
    .iOS(.v15)
  ],
  products: [
    .library(name: "User", targets: ["User"])
  ],
  targets: [
    .target(name: "User")
  ]
)
