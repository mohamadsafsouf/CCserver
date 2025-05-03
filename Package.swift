// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "KeyCC",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(name: "KeyCC", targets: ["KeyCC"])
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.110.1"),
        .package(url: "https://github.com/apple/swift-crypto.git", from: "2.0.0")
    ],
    targets: [
        .executableTarget(
            name: "KeyCC",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "Crypto", package: "swift-crypto")
            ]
        ),
        .testTarget(
            name: "KeyCCTests",
            dependencies: ["KeyCC"]
        )
    ]
)
