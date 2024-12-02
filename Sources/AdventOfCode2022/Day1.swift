//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 03.12.23.
//

import Foundation
import Utils


public struct Day1: Day {
	public init(_ input: Lines) {
		self.lines = input
	}
	
	let lines: Lines

	public func part1() async throws -> String {
		var maxValue = 0
		var current = 0
		
		for line in lines {
			if line.isEmpty {
				maxValue = max(maxValue, current)
				current = 0
			} else {
				current += Int(line) ?? 0
			}
		}
		
		return maxValue.formatted(.number.grouping(.never))
	}
	
	public func part2() async throws -> String {
		lines
			.split(separator: "")
			.compactMap { values in
				values.reduce(0) { $0 + Int($1)! }
			}
			.sorted(using: KeyPathComparator(\.self, order: .reverse))
			.prefix(3)
			.reduce(0, +)
			.formatted(.number.grouping(.never))
	}
}
