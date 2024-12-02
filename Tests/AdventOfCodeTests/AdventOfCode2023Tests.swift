import Testing
import AdventOfCode2023
import Utils


@Suite("Advent of Code 2023")
struct AdventOfCode2023Tests {

	@Test("Day 1")
	func day1() async throws {
		let day1 = Day1(Lines(fileName: "2023-01", bundle: .module))
		let day1_2 = Day1(Lines(fileName: "2023-01-02", bundle: .module))
		let part1 = try await day1.part1()
		let part2 = try await day1_2.part2()
		#expect(part1 == "142")
		#expect(part2 == "281")
	}
	
	@Test("Day 2")
	func day2() async throws {
		let day2 = Day2(Lines(fileName: "2023-02", bundle: .module))
		let part1 = try await day2.part1()
		let part2 = try await day2.part2()
		#expect(part1 == "8")
		#expect(part2 == "2286")
	}
	
	@Test("Day 3")
	func day3() async throws {
		let day3 = Day3(Lines(fileName: "2023-03", bundle: .module))
		let part1 = try await day3.part1()
		let part2 = try await day3.part2()
		#expect(part1 == "4361")
		#expect(part2 == "467835")
	}
	
	@Test("Day 4")
	func day4() async throws {
		let day4 = Day4(Lines(fileName: "2023-04", bundle: .module))
		let day4_2 = Day4(Lines(fileName: "2023-04-02", bundle: .module))
		let part1 = try await day4.part1()
		let part2 = try await day4_2.part2()
		#expect(part1 == "13")
		#expect(part2 == "30")
	}
	
//	@Test("Day 5")
//	func day5() async throws {
//		let day5 = Day5(Lines(fileName: "2023-05", bundle: .module))
//		let part1 = try await day5.part1()
//		let part2 = try await day5.part2()
//		#expect(part1 == "35")
//		#expect(part2 == "46")
//	}
	
	@Test("Day 6")
	func day6() async throws {
		let day6 = Day6(Lines(fileName: "2023-06", bundle: .module))
		let part1 = try await day6.part1()
		let part2 = try await day6.part2()
		#expect(part1 == "288")
		#expect(part2 == "71503")
	}
	
//	@Test("Day 7")
//	func day7() async throws {
//		let day7 = Day7(Lines(fileName: "2023-07", bundle: .module))
//		let day7_2 = Day7(Lines(fileName: "2023-07-02", bundle: .module))
//		let part1 = try await day7.part1()
//		let part2 = try await day7_2.part2()
//		#expect(part1 == "6440")
//		#expect(part2 == "5905")
//	}
	
	@Test("Day 8")
	func day8() async throws {
		let day8 = Day8(Lines(fileName: "2023-08", bundle: .module))
		let day8_2 = Day8(Lines(fileName: "2023-08-02", bundle: .module))
		let part1 = try await day8.part1()
		let part2 = try await day8_2.part2()
		#expect(part1 == "2")
		#expect(part2 == "6")
	}
	
	@Test("Day 9")
	func day9() async throws {
		let day9 = Day9(Lines(fileName: "2023-09", bundle: .module))
		let part1 = try await day9.part1()
		let part2 = try await day9.part2()
		#expect(part1 == "114")
		#expect(part2 == "2")
	}
}
