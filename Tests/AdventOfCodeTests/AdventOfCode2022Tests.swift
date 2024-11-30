import Testing
@testable import AdventOfCode2022


@Suite("Advent of Code 2022")
struct AdventOfCode2022Tests {
	
	@Test func day1_part1() throws {
		#expect(Day1.part1() == 66719)
	}
	
	@Test func day1_part2() throws {
		#expect(Day1.part2() == 198551)
	}
	
	@Test func day2_part1() {
		#expect(Day2.part1() == 8933)
	}
	
	@Test func day2_part2() {
		#expect(Day2.part2() == 11998)
	}

	@Test func day3_part1() {
		#expect(Day3.part1() == 8053)
	}
	
	@Test func day3_part2() {
		#expect(Day3.part2() == 0)
	}
}
