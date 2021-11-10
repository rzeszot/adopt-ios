// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "Welcome",
  platforms: [
    .iOS(.v15)
  ],
  products: [
    .library(name: "Welcome", targets: ["Welcome"])
  ],
  targets: [
    .target(name: "Welcome")
  ]
)
