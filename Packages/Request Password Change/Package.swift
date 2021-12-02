// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "RequestPasswordChange",
  platforms: [
    .iOS(.v15)
  ],
  products: [
    .library(name: "RequestPasswordChange", targets: ["RequestPasswordChange"])
  ],
  dependencies: [
    .package(path: "Networking")
  ],
  targets: [
    .target(name: "RequestPasswordChange", dependencies: ["Networking"])
  ]
)
