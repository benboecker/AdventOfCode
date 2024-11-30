import Testing
@testable import AdventOfCode2023

@Suite("Advent of Code 2023")
struct AdventOfCode2023Tests {

	@Test func Day1_part1() throws {
		#expect(Day1.part1() == 55002)
	}
	
	@Test func Day1_part2() throws {
		#expect(Day1.part2() == 55093)
	}
	
	@Test func Day2_part1() {
		#expect(Day2.part1() == 2061)
	}
	
	@Test func Day2_part2() {
		#expect(Day2.part2() == 72596)
	}
	
	@Test func Day3_part1() {
		#expect(Day3.part1() == 536576)
	}
	
	@Test func Day3_part2() {
		#expect(Day3.part2() == 75741499)
	}
	
	@Test func Day4_part1() {
		#expect(Day4.part1() == 20407)
	}
	
	@Test func Day4_part2() {
		let input = """
Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
"""
		#expect(Day4.part2(input: input.components(separatedBy: .newlines)) == 30)
		print(Day4.part2())
	}
	
	@Test func Day5_part1() {
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
		#expect(Day5.part1(input: input) == 35)
		print(Day5.part1())
	}
	
	@Test func Day5_part2() {
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
		#expect(Day5.part2(input: input) == 46)
		//		print(Day5.part2())
	}
	
	@Test func Day6_part1() {
		let input = """
Time:      7  15   30
Distance:  9  40  200
"""
		#expect(Day6.part1(input: input.components(separatedBy: .newlines)) == 288)
		print(Day6.part1())
	}
	
	@Test func Day6_part2() {
		let input = """
Time:      7  15   30
Distance:  9  40  200
"""
		#expect(Day6.part2(input: input.components(separatedBy: .newlines)) == 71503)
		print(Day6.part2())
	}
	
	@Test func Day7_part1() {
		let input = """
32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483
"""
		#expect(Day7.part1(input: input.components(separatedBy: .newlines)) == 6440)
		print(Day7.part1())
	}
	
	@Test func Day7_part2() {
		//		let input = """
		//32T3K 765
		//T55J5 684
		//KK677 28
		//KTJJT 220
		//QQQJA 483
		//"""
		//		XCTAssertEqual(Day7_Part2.part2(input: input.components(separatedBy: .newlines)), 5905)
		print(Day7_Part2.part2())
	}
	
	@Test func Day8_part1() {
		let input = """
LLR

AAA = (BBB, BBB)
BBB = (AAA, ZZZ)
ZZZ = (ZZZ, ZZZ)
"""
		#expect(Day8.part1(input: input.components(separatedBy: .newlines)) == 6)
		print(Day8.part1())
	}
	
	@Test func Day8_part2() {
		let input = """
LR

11A = (11B, XXX)
11B = (XXX, 11Z)
11Z = (11B, XXX)
22A = (22B, XXX)
22B = (22C, 22C)
22C = (22Z, 22Z)
22Z = (22B, 22B)
XXX = (XXX, XXX)
"""
		#expect(Day8.part2(input: input.components(separatedBy: .newlines)) == 6)
		print(Day8.part2())
	}
		
	@Test func Day9_part1() {
		let input = """
0 3 6 9 12 15
1 3 6 10 15 21
10 13 16 21 30 45
"""
		#expect(Day9.part1(input: input.components(separatedBy: .newlines)) == 114)
		print(Day9.part1())
	}
	
	@Test func Day9_part2() {
		let input = """
10 13 16 21 30 45
"""
		#expect(Day9.part2(input: input.components(separatedBy: .newlines)) == 5)
		print(Day9.part2())
	}
}
