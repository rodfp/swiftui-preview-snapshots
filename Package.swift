// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "swiftui-preview-snapshots",
    platforms: [
        .iOS(.v13),
        .tvOS(.v13),
    ],
    products: [
        .library(
            name: "PreviewSnapshot",
            targets: ["PreviewSnapshot"]
        ),
        
        .library(
            name: "PreviewSnapshotsTesting",
            targets: ["PreviewSnapshotsTesting"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.10.0"),
    ],
    targets: [
        // PreviewSnapshots target with no dependancies that can be imported into app code
        .target(
            name: "PreviewSnapshot",
            dependencies: [],
            path: "Sources/PreviewSnapshots"
        ),
        
        // PreviewSnapshotTesting target the depends on `SnapshotTesting` for use in tests
        .target(
            name: "PreviewSnapshotsTesting",
            dependencies: [
                "PreviewSnapshot",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ]
        ),
        
        // Tests
        .testTarget(
            name: "PreviewSnapshotsTests",
            dependencies: [
                "PreviewSnapshot",
                "PreviewSnapshotsTesting",
            ]
        ),
    ]
)
