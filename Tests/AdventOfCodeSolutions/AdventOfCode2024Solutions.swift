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
struct AdventOfCodeSolutions {
	
	@Test("Solutions")
	func solutions() async throws {
		let days: [any Day] = [
			Day1(Lines(fileName: "2024-01", bundle: .module)),
			Day2(Lines(fileName: "2024-02", bundle: .module)),
		]
		
		for (index, day) in days.enumerated() {
			try await day.printDay(index)
		}
		
		print("")
	}

}
