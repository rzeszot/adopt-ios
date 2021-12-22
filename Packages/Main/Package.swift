// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "Main",
  platforms: [
    .iOS(.v15)
  ],
  products: [
    .library(name: "Main", targets: ["Main"])
  ],
  targets: [
    .target(name: "Main")
  ]
)
