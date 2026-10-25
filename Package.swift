// swift-tools-version: 6.2
import PackageDescription

let package = Package(
  name: "PetrelBluemoji",
  platforms: [.iOS(.v18), .macOS(.v15)],
  products: [.library(name: "PetrelBluemoji", targets: ["PetrelBluemoji"])],
  dependencies: [.package(url: "https://github.com/joshlacal/Petrel.git", revision: "cc2999e1f4746a7c246d76dce09f4176ec0768a1")],
  targets: [
    .target(
      name: "PetrelBluemoji",
      dependencies: [.product(name: "Petrel", package: "Petrel")],
      path: "Sources/PetrelBluemoji"),
  ]
)
