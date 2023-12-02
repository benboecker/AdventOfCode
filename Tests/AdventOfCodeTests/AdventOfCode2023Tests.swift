import XCTest
@testable import AdventOfCode

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
}
