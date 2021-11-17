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
  dependencies: [
    .package(name: "AwesomeKeyboardLayoutGuide", url: "https://github.com/rzeszot/swift-awesome-keyboard-layout-guide.git", branch: "main")
  ],
  targets: [
    .target(name: "Chat", dependencies: ["AwesomeKeyboardLayoutGuide"])
  ]
)
