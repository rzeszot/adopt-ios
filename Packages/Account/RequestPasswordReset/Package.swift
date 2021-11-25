// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "RequestPasswordReset",
  platforms: [
    .iOS(.v15)
  ],
  products: [
    .library(name: "RequestPasswordReset", targets: ["RequestPasswordReset"])
  ],
  dependencies: [
    .package(name: "Mocky", url: "https://github.com/rzeszot/swift-http-mocky.git", branch: "main"),
    .package(path: "../../Networking"),
    .package(path: "../../Common/Process"),
    .package(path: "../../Common/Unexpected")
  ],
  targets: [
    .target(name: "RequestPasswordReset", dependencies: ["Unexpected", "Networking", "Process"]),
    .testTarget(name: "RequestPasswordResetTests", dependencies: ["RequestPasswordReset", "Mocky"], resources: [
      .copy("Responses")
    ])
  ]
)
