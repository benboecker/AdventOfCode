//
//  Test.swift
//  AdventOfCode
//
//  Created by Benjamin Böcker on 30.11.24.
//

import Testing
import AdventOfCode2024
import Utils


@Suite("Advent of Code 2024")
struct AdventOfCode2024 {
	
	@Test("Day 1")
	func day1() async throws {
		let day1 = Day1(Lines(fileName: "2024-01", bundle: .module))
		let part1 = try await day1.part1()
		let part2 = try await day1.part2()
		#expect(part1 == "11")
		#expect(part2 == "31")
	}

	@Test("Day 2")
	func day2() async throws {
		let day2 = Day2(Lines(fileName: "2024-02", bundle: .module))
		let part1 = try await day2.part1()
		let part2 = try await day2.part2()
		#expect(part1 == "2")
		#expect(part2 == "4")
	}
	
}
