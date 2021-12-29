// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "Onboarding",
  platforms: [
    .iOS(.v15)
  ],
  products: [
    .library(name: "Onboarding", targets: ["Onboarding"])
  ],
  dependencies: [
    .package(name: "XCSnapshots", url: "https://github.com/rzeszot/swift-xcsnapshots", branch: "main")
  ],
  targets: [
    .target(name: "Onboarding"),
    .testTarget(name: "OnboardingTests", dependencies: ["Onboarding", "XCSnapshots"])
  ]
)
