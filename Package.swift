import PackageDescription

let package = Package(
    name: "TestVapor",
    targets: [
        Target(name: "App", dependencies: [])
    ],
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", "1.1.12"),
        .Package(url: "https://github.com/honghaoz/Ji.git", majorVersion: 2)
    ],
    exclude: [
        "Config",
        "Database",
        "Localization",
        "Public",
        "Resources",
        "Tests",
    ]
)

