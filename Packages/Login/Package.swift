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
    .package(name: "Mocky", url: "https://github.com/rzeszot/swift-http-mocky.git", branch: "main"),
    .package(name: "Weak", url: "https://github.com/rzeszot/swift-weak.git", branch: "main"),
    .package(path: "Networking")
  ],
  targets: [
    .target(name: "Login", dependencies: ["Networking", "Weak"]),
    .testTarget(name: "LoginTests", dependencies: ["Login", "Mocky"], resources: [
      .copy("Mocky")
    ])
  ]
)
