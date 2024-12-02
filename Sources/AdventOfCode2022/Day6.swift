//
//  File.swift
//  AdventOfCode
//
//  Created by Benjamin Böcker on 30.11.24.
//

import Foundation
import Utils


public struct Day6: Day {
	public init(_ input: Utils.Lines) {
		self.sequence = input[0]
	}
	
	let sequence: String
	
	public func part1() async throws -> String {
		for index in 4 ..< sequence.count {
			let current = sequence[index - 4 ..< index]
			
			if current.hasDifferentCharacters {
				return index.formatted(.number.grouping(.never))
			}
		}
		
		throw AdventError.generic("No solution found")
	}
	
	public func part2() async throws -> String {
		for index in 14..<sequence.count {
			let current = sequence[index - 14 ..< index]
			
			if current.hasDifferentCharacters {
				return index.formatted(.number.grouping(.never))
			}
		}
		
		throw AdventError.generic("No solution found")
	}
}
