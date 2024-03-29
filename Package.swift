// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "PreviewView",
    platforms: [
        .iOS(.v11),
    ],
    products: [
        .library(name: "PreviewView", targets: ["PreviewView"]),
        .library(name: "PreviewViewLegacyOSCompileFix", targets: ["PreviewViewLegacyOSCompileFix"]),
    ],
    targets: [
        .target(name: "PreviewView"),
        .target(name: "PreviewViewLegacyOSCompileFix"),
    ]
)
