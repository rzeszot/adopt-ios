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
    .package(name: "Mocky", url: "https://github.com/rzeszot/swift-http-mocky.git", branch: "main"),
    .package(path: "../../Networking"),
    .package(path: "../../Common/Fixture"),
    .package(path: "../../Common/Process"),
    .package(path: "../../Common/Unexpected")
  ],
  targets: [
    .target(name: "ConfirmPasswordChange", dependencies: ["Unexpected", "Networking", "Process"]),
    .testTarget(name: "ConfirmPasswordChangeTests", dependencies: ["ConfirmPasswordChange", "Mocky", "Fixture"], resources: [
      .copy("Responses")
    ])
  ]
)
