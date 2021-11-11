// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "Chat",
  platforms: [
    .iOS(.v15)
  ],
  products: [
    .library(name: "Chat", targets: ["Chat"])
  ],
  targets: [
    .target(name: "Chat")
  ]
)
