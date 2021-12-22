// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "ConfirmPasswordChange",
  platforms: [
    .iOS(.v15)
  ],
  products: [
    .library(name: "ConfirmPasswordChange", targets: ["ConfirmPasswordChange"])
  ],
  dependencies: [
    .package(path: "Networking")
  ],
  targets: [
    .target(name: "ConfirmPasswordChange", dependencies: ["Networking"])
  ]
)
