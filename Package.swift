// swift-tools-version: 6.2
import PackageDescription

let package = Package(
  name: "PetrelBluemoji",
  platforms: [.iOS(.v18), .macOS(.v15)],
  products: [.library(name: "PetrelBluemoji", targets: ["PetrelBluemoji"])],
  dependencies: [.package(url: "https://github.com/joshlacal/Petrel.git", revision: "819e6fc3363e4b0973b191a593af6b0f25b63bf3")],
  targets: [
    .target(
      name: "PetrelBluemoji",
      dependencies: [.product(name: "Petrel", package: "Petrel")],
      path: "Sources/PetrelBluemoji"),
  ]
)
