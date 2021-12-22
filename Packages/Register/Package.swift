// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "Register",
  platforms: [
    .iOS(.v15)
  ],
  products: [
    .library(name: "Register", targets: ["Register"])
  ],
  targets: [
    .target(name: "Register")
  ]
)
