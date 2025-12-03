//
//  Test.swift
//  AdventOfCode
//
//  Created by Benjamin Böcker on 30.11.24.
//

import Testing
import AdventOfCode2025
import Utils


@Suite("Advent of Code 2025")
struct AdventOfCode2025 {
	
	@Test("Day 1 - Part 1")
	func day1Part1() async throws {
		let day1 = Day1(Lines(fileName: "2025-01", bundle: .module))
		let part1 = try await day1.part1()
		#expect(part1 == "3")
	}
	
	@Test("Day 1 - Part 2")
	func day1Part2() async throws {
		let day1 = Day1(Lines(fileName: "2025-01", bundle: .module))
		let part2 = try await day1.part2()
		#expect(part2 == "6")
	}
	
	
	@Test("Day 2 - Part 1")
	func day2Part1() async throws {
		let day2 = Day2(Lines(fileName: "2025-02", bundle: .module))
		let part1 = try await day2.part1()
		#expect(part1 == "1227775554")
	}
	
	@Test("Day 2 - Part 2")
	func day2Part2() async throws {
		let day2 = Day2(Lines(fileName: "2025-02", bundle: .module))
		let part2 = try await day2.part2()
		#expect(part2 == "4174379265")
	}
	
	
	@Test("Day 3 - Part 1")
	func day3Part1() async throws {
		let day3 = Day3(Lines(fileName: "2025-03", bundle: .module))
		let part1 = try await day3.part1()
		#expect(part1 == "357")
	}
	
	@Test("Day 3 - Part 2")
	func day3Part2() async throws {
		let day3 = Day3(Lines(fileName: "2025-03", bundle: .module))
		let part2 = try await day3.part2()
		#expect(part2 == "3121910778619")
	}
	
	
}
