// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "AdventOfCode",
	platforms: [.iOS(.v17), .macOS(.v14)],
	products: [
		.library(name: "AdventOfCode2022", targets: ["AdventOfCode2022"]),
		.library(name: "AdventOfCode2023", targets: ["AdventOfCode2023"]),
		.library(name: "AdventOfCode2024", targets: ["AdventOfCode2024"]),
		.library(name: "Utils", targets: ["Utils"]),
	],
	targets: [
		.target(name: "AdventOfCode2022", dependencies: ["Utils"]),
		.target(name: "AdventOfCode2023", dependencies: ["Utils"], resources: [
			.process("Resources"),
		]),
		.target(name: "AdventOfCode2024", dependencies: ["Utils"]),
		.target(name: "Utils"),
		.testTarget(name: "AdventOfCodeTests", dependencies: [
			"AdventOfCode2022",
			"AdventOfCode2023",
			"AdventOfCode2024",
		], resources: [
			.process("Resources/2022"),
			.process("Resources/2023"),
			.process("Resources/2024"),
		]),
		.testTarget(name: "AdventOfCodeSolutions", dependencies: [
			"AdventOfCode2022",
			"AdventOfCode2023",
			"AdventOfCode2024",
		], resources: [
			.process("Resources/2022"),
			.process("Resources/2023"),
			.process("Resources/2024"),
		]),

	]
)
