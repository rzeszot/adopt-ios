// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "Profile",
  platforms: [
    .iOS(.v15)
  ],
  products: [
    .library(name: "Profile", targets: ["Profile"])
  ],
  targets: [
    .target(name: "Profile")
  ]
)
