// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "RemindPassword",
  platforms: [
    .iOS(.v15)
  ],
  products: [
    .library(name: "RemindPassword", targets: ["RemindPassword"])
  ],
  dependencies: [
    .package(name: "Mocky", url: "https://github.com/rzeszot/swift-http-mocky.git", branch: "main"),
    .package(path: "../Networking"),
    .package(path: "../Extraction/Unexpected")
  ],
  targets: [
    .target(name: "RemindPassword", dependencies: ["Unexpected", "Networking"]),
    .testTarget(name: "RemindPasswordTests", dependencies: ["RemindPassword", "Mocky"], resources: [
      .copy("Responses")
    ])
  ]
)
