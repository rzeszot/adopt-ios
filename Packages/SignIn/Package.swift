// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "SignIn",
  platforms: [
    .iOS(.v15)
  ],
  products: [
    .library(name: "SignIn", targets: ["SignIn"])
  ],
  dependencies: [
    .package(name: "Mocky", url: "https://github.com/rzeszot/swift-http-mocky.git", branch: "main")
  ],
  targets: [
    .target(name: "SignIn"),
    .testTarget(name: "SignInTests", dependencies: ["SignIn", "Mocky"])
  ]
)
