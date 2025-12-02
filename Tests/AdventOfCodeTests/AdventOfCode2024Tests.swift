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
	
	@Test("Day 3")
	func day3() async throws {
		let day3 = Day3(Lines(fileName: "2024-03", bundle: .module))
		let part1 = try await day3.part1()
		let part2 = try await day3.part2()
		#expect(part1 == "161")
		#expect(part2 == "48")
	}
	
	@Test("Day 4")
	func day4() async throws {
		let day4 = Day4(Lines(fileName: "2024-04", bundle: .module))
		let part1 = try await day4.part1()
		let part2 = try await day4.part2()
		#expect(part1 == "18")
		#expect(part2 == "9")
	}
	
	@Test("Day 5")
	func day5() async throws {
		let day5 = Day5(Lines(fileName: "2024-05", bundle: .module))
		let part1 = try await day5.part1()
		let part2 = try await day5.part2()
		#expect(part1 == "143")
		#expect(part2 == "123")
	}
	
	@Test("Day 6")
	func day6() async throws {
		let day6 = Day6(Lines(fileName: "2024-06", bundle: .module))
		let part1 = try await day6.part1()
		let part2 = try await day6.part2()
		#expect(part1 == "41")
		#expect(part2 == "")
	}
	
	@Test("Day 7")
	func day7() async throws {
		let day7 = Day7(Lines(fileName: "2024-07", bundle: .module))
		let part1 = try await day7.part1()
		let part2 = try await day7.part2()
		#expect(part1 == "")
		#expect(part2 == "")
	}
	
	@Test("Day 8")
	func day8() async throws {
		let day8 = Day8(Lines(fileName: "2024-08", bundle: .module))
		let part1 = try await day8.part1()
		let part2 = try await day8.part2()
		#expect(part1 == "14")
		#expect(part2 == "34")
	}
	
	@Test("Day 9")
	func day9() async throws {
		let day9 = Day9(Lines(fileName: "2024-09", bundle: .module))
		let part1 = try await day9.part1()
		let part2 = try await day9.part2()
		#expect(part1 == "1928")
		#expect(part2 == "")
	}
	
	@Test("Day 10")
	func day10() async throws {
		let day10 = Day10(Lines(fileName: "2024-10", bundle: .module))
		let part1 = try await day10.part1()
		let part2 = try await day10.part2()
		#expect(part1 == "36")
		#expect(part2 == "81")
	}
	
	@Test("Day 11")
	func day11() async throws {
//		let day11 = Day11(Lines(fileName: "2024-11", bundle: .module))
//		let part1 = try await day11.part1()
		//		let part2 = try await day11.part2()
//		#expect(part1 == "22")
		//		#expect(part2 == "")
	}
	
	@Test("Day 23")
	func day23() async throws {
		let day23 = Day23(Lines(fileName: "2024-23", bundle: .module))
		let part1 = try await day23.part1()
		let part2 = try await day23.part2()
		#expect(part1 == "7")
		#expect(part2 == "co,de,ka,ta")
	}
}
