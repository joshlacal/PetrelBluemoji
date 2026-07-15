// swift-tools-version: 6.0
import PackageDescription

let package = Package(
  name: "PetrelBluemoji",
  platforms: [.iOS(.v18), .macOS(.v15)],
  products: [.library(name: "PetrelBluemoji", targets: ["PetrelBluemoji"])],
  dependencies: [.package(path: "../Petrel")],
  targets: [
    .target(
      name: "PetrelBluemoji",
      dependencies: [.product(name: "Petrel", package: "Petrel")],
      path: "Sources/PetrelBluemoji"),
  ]
)
