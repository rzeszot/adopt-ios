// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "Login",
  platforms: [
    .iOS(.v15)
  ],
  products: [
    .library(name: "Login", targets: ["Login"])
  ],
  dependencies: [
    .package(name: "Mocky", url: "https://github.com/rzeszot/swift-http-mocky", branch: "main"),
    .package(name: "Weak", url: "https://github.com/rzeszot/swift-weak", branch: "main"),
    .package(name: "XCSnapshots", url: "https://github.com/rzeszot/swift-xcsnapshots", branch: "main"),
    .package(path: "Networking")
  ],
  targets: [
    .target(name: "Login", dependencies: ["Networking", "Weak"]),
    .testTarget(name: "LoginTests", dependencies: ["Login", "Mocky", "XCSnapshots"], resources: [
      .copy("_Snapshots"),
      .copy("Mocky")
    ])
  ]
)
