// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "AdventOfCode",
	platforms: [.iOS(.v17)],
	products: [
		.library(name: "AdventOfCode", targets: ["AdventOfCode"]),
	],
	targets: [
		.target(name: "AdventOfCode", resources: [
			.process("2023/Resources")
		]),
		.testTarget(name: "AdventOfCodeTests",dependencies: ["AdventOfCode"]),
	]
)
