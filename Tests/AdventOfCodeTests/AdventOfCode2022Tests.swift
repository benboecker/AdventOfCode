import Testing
import AdventOfCode2022
import Utils


@Suite("Advent of Code 2022")
struct AdventOfCode2022Tests {
	
	@Test("Day 1")
	func day1() async throws {
		let day1 = Day1(Lines(fileName: "2022-01", bundle: .module))
		let part1 = try await day1.part1()
		let part2 = try await day1.part2()
		#expect(part1 == "24000")
		#expect(part2 == "45000")
	}
	
	@Test("Day 2")
	func day2() async throws {
		let day2 = Day2(Lines(fileName: "2022-02", bundle: .module))
		let part1 = try await day2.part1()
		let part2 = try await day2.part2()
		#expect(part1 == "15")
		#expect(part2 == "12")
	}
	
	@Test("Day 3")
	func day3() async throws {
		let day3 = Day3(Lines(fileName: "2022-03", bundle: .module))
		let part1 = try await day3.part1()
		let part2 = try await day3.part2()
		#expect(part1 == "157")
		#expect(part2 == "70")
	}
	
	@Test("Day 4")
	func day4() async throws {
		let day4 = Day4(Lines(fileName: "2022-04", bundle: .module))
		let part1 = try await day4.part1()
		let part2 = try await day4.part2()
		#expect(part1 == "2")
		#expect(part2 == "4")
	}
	
	@Test("Day 5")
	func day5() async throws {
		let day5 = Day5(Lines(fileName: "2022-05", bundle: .module))
		let part1 = try await day5.part1()
		let part2 = try await day5.part2()
		#expect(part1 == "CMZ")
		#expect(part2 == "MCD")
	}
	
	@Test("Day 6")
	func day6() async throws {
		let day6 = Day6(Lines(fileName: "2022-06", bundle: .module))
		let part1 = try await day6.part1()
		let part2 = try await day6.part2()
		#expect(part1 == "7")
		#expect(part2 == "19")
	}
	
//	@Test("Day 7")
//	func day7() async throws {
//		let day7 = Day7(Lines(fileName: "2022-07", bundle: .module))
//		let part1 = try await day7.part1()
////		let part2 = try await day7.part2()
//		#expect(part1 == "95437")
////		#expect(part2 == "19")
//	}
}
