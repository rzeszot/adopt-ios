// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "Privacy",
  platforms: [
    .iOS(.v15)
  ],
  products: [
    .library(name: "Privacy", targets: ["Privacy"])
  ],
  targets: [
    .target(name: "Privacy")
  ]
)
