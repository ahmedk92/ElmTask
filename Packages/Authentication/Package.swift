// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private let PACKAGE_NAME = "Authentication"
private let DOMAIN_TARGET_NAME = PACKAGE_NAME + "Domain"
private let DATA_TARGET_NAME = PACKAGE_NAME + "Data"
private let UI_TARGET_NAME = PACKAGE_NAME + "UI"
private let DI_TARGET_NAME = PACKAGE_NAME + "DI"
private let UMBRELLA_TARGET_NAME = PACKAGE_NAME

let package = Package(
    name: PACKAGE_NAME,
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: PACKAGE_NAME,
            targets: [
                UMBRELLA_TARGET_NAME
            ]
        ),
    ],
    targets: [
        .target(
            name: DOMAIN_TARGET_NAME
        ),
        .target(
            name: DATA_TARGET_NAME,
            dependencies: [
                .target(name: DOMAIN_TARGET_NAME)
            ]
        ),
        .target(
            name: UI_TARGET_NAME,
            dependencies: [
                .target(name: DOMAIN_TARGET_NAME)
            ]
        ),
        .target(
            name: DI_TARGET_NAME,
            dependencies: [
                .target(name: DOMAIN_TARGET_NAME),
                .target(name: UI_TARGET_NAME),
                .target(name: DATA_TARGET_NAME)
            ]
        ),
        .target(
            name: UMBRELLA_TARGET_NAME,
            dependencies: [
                .target(name: DI_TARGET_NAME),
            ]
        )
    ]
)
