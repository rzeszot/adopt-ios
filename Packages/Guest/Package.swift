// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "Guest",
  platforms: [
    .iOS(.v15)
  ],
  products: [
    .library(name: "Guest", targets: ["Guest"])
  ],
  targets: [
    .target(name: "Guest")
  ]
)
