// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "Dashboard",
  platforms: [
    .iOS(.v15)
  ],
  products: [
    .library(name: "Dashboard", targets: ["Dashboard"])
  ],
  targets: [
    .target(name: "Dashboard")
  ]
)
