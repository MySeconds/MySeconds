import ProjectDescription

let project = Project(
    name: "MySeconds",
    packages: [
        .package(url: "https://github.com/DevYeom/ModernRIBs.git", from: "1.0.0"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.0.0")
    ],
    targets: [
        .target(
            name: "MySeconds",
            destinations: .iOS,
            product: .app,
            bundleId: "com.panestudio.myseconds",
            infoPlist: .extendingDefault(
                with: [
                    "UIApplicationSceneManifest": [
                        "UIApplicationSupportsMultipleScenes": false
                    ],
                    "UIApplicationMainStoryboardFile": ""
                ]
            ),
            sources: ["MySeconds/Sources/**"],
            resources: ["MySeconds/Resources/**"],
            scripts: [
                .pre(
                    script: """
                    export PATH="$PATH:/opt/homebrew/bin:/usr/local/bin"
                    swiftlint lint --reporter xcode
                    """,
                    name: "SwiftLint",
                    basedOnDependencyAnalysis: false
                ),
                .pre(
                    script: """
                    export PATH="$PATH:/opt/homebrew/bin:/usr/local/bin"
                    swiftformat .
                    """,
                    name: "SwiftFormat",
                    basedOnDependencyAnalysis: false
                )
            ],
            dependencies: [
                .package(product: "ModernRIBs", type: .runtime),
                .package(product: "SnapKit", type: .runtime),
                .project(target: "ResourceKit", path: "Modules/ResourceKit")
            ],
            settings: .settings(
                base: [
                    "SWIFT_VERSION": "6.0",
                    "CODE_SIGN_IDENTITY": "Apple Development",
                    "DEVELOPMENT_TEAM": "CB95NTZJ5Z",
                    "PROVISIONING_PROFILE_SPECIFIER": "MySeconds"
                ]
            )
        ),
        .target(
            name: "MySecondsTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.panestudio.myseconds",
            infoPlist: .default,
            sources: ["MySeconds/Tests/**"],
            resources: [],
            dependencies: [.target(name: "MySeconds")],
            settings: .settings(
                base: [
                    "SWIFT_VERSION": "6.0",
                    "CODE_SIGN_IDENTITY": "Apple Development",
                    "DEVELOPMENT_TEAM": "CB95NTZJ5Z",
                    "PROVISIONING_PROFILE_SPECIFIER": "MySeconds"
                ]
            )
        )
    ]
)
