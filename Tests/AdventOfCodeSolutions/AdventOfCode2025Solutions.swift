//
//  Test.swift
//  AdventOfCode
//
//  Created by Benjamin Böcker on 30.11.24.
//

import Testing
import AdventOfCode2025
import Utils


@Suite("Advent of Code 2025 - Solutions")
struct AdventOfCode2025Solutions {
	
	@Test("Solutions")
	func solutions() async throws {
		let days: [any Day] = [
			Day1(Lines(fileName: "2025-01", bundle: .module)),
		]
		
		for (index, day) in days.enumerated() {
			try await day.printDay(index)
		}
		
		print("")
	}

}
