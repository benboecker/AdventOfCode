import XCTest
@testable import AdventOfCode2022


final class AdventOfCode2022Tests: XCTestCase {
	
	func test_day1_part1() throws {
		XCTAssertEqual(Day1.part1(), 66719)
	}
	
	func test_day1_part2() throws {
		XCTAssertEqual(Day1.part2(), 198551)
	}
	
	func test_day2_part1() {
		XCTAssertEqual(Day2.part1(), 8933)
	}
	
	func test_day2_part2() {
		XCTAssertEqual(Day2.part2(), 11998)
	}

	func test_day3_part1() {
		XCTAssertEqual(Day3.part1(), 8053)
	}
	
	func test_day3_part2() {
		XCTAssertEqual(Day3.part2(), -1)
	}
}
