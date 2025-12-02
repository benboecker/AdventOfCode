//
//  Test.swift
//  AdventOfCode
//
//  Created by Benjamin Böcker on 30.11.24.
//

import Testing
import AdventOfCode2024
import Utils


@Suite("Advent of Code 2024 - Solutions")
struct AdventOfCode2024Solutions {
	
	@Test("Solutions")
	func solutions() async throws {
		let days: [any Day] = [
			Day1(Lines(fileName: "2024-01", bundle: .module)),
			Day2(Lines(fileName: "2024-02", bundle: .module)),
			Day3(Lines(fileName: "2024-03", bundle: .module)),
			Day4(Lines(fileName: "2024-04", bundle: .module)),
			Day5(Lines(fileName: "2024-05", bundle: .module)),
			Day6(Lines(fileName: "2024-06", bundle: .module)),
			Day7(Lines(fileName: "2024-07", bundle: .module)),
			Day8(Lines(fileName: "2024-08", bundle: .module)),
//			Day9(Lines(fileName: "2024-09", bundle: .module)),
//			Day10(Lines(fileName: "2024-10", bundle: .module)),
//			Day11(Lines(fileName: "2024-11", bundle: .module)),
			Day23(Lines(fileName: "2024-23", bundle: .module)),
		]
		
		for (index, day) in days.enumerated() {
			try await day.printDay(index)
		}
		
		print("")
	}

}
