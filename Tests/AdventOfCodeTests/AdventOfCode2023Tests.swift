import XCTest
@testable import AdventOfCode2023

final class AdventOfCode2023Tests: XCTestCase {
	
	func test_day1_part1() throws {
		XCTAssertEqual(Day1.part1(), 55002)
	}
	
	func test_day1_part2() throws {
		XCTAssertEqual(Day1.part2(), 55093)
	}
	
	func test_day2_part1() {
		XCTAssertEqual(Day2.part1(), 2061)
	}
	
	func test_day2_part2() {
		XCTAssertEqual(Day2.part2(), 72596)
	}
	
	func test_day3_part1() {
		XCTAssertEqual(Day3.part1(), 536576)
	}
	
	func test_day3_part2() {
		XCTAssertEqual(Day3.part2(), 75741499)
	}
	
	func test_day4_part1() {
		XCTAssertEqual(Day4.part1(), 20407)
	}
	
	func test_day4_part2() {
		let input = """
Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
"""
		XCTAssertEqual(Day4.part2(input: input.components(separatedBy: .newlines)), 30)
		print(Day4.part2())
	}
	
	
	func test_day5_part1() {
		let input = """
seeds: 79 14 55 13

seed-to-soil map:
50 98 2
52 50 48

soil-to-fertilizer map:
0 15 37
37 52 2
39 0 15

fertilizer-to-water map:
49 53 8
0 11 42
42 0 7
57 7 4

water-to-light map:
88 18 7
18 25 70

light-to-temperature map:
45 77 23
81 45 19
68 64 13

temperature-to-humidity map:
0 69 1
1 0 69

humidity-to-location map:
60 56 37
56 93 4
"""
		XCTAssertEqual(Day5.part1(input: input), 35)
		print(Day5.part1())
	}
	
	
	func test_day5_part2() {
		let input = """
seeds: 79 14 55 13

seed-to-soil map:
50 98 2
52 50 48

soil-to-fertilizer map:
0 15 37
37 52 2
39 0 15

fertilizer-to-water map:
49 53 8
0 11 42
42 0 7
57 7 4

water-to-light map:
88 18 7
18 25 70

light-to-temperature map:
45 77 23
81 45 19
68 64 13

temperature-to-humidity map:
0 69 1
1 0 69

humidity-to-location map:
60 56 37
56 93 4
"""
		XCTAssertEqual(Day5.part2(input: input), 46)
		print(Day5.part2())
	}
}
