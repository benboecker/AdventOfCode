//
//  File.swift
//  AdventOfCode
//
//  Created by Benjamin Böcker on 30.11.24.
//

import Foundation
import Utils



public struct Day5: Day {
	public init(_ input: Lines) {
		let splitted = input.split(separator: "")
		
		self.operations = splitted[1]
			.filter { !$0.isEmpty }
			.map { CraneOperation.init($0) }
		
		self.crates = Crates(lines: Array(splitted[0]))

	}
	
	private let operations: [CraneOperation]
	private var crates: Crates
	
	public func part1() async throws -> String {
		var copy = crates
		for operation in operations {
			copy.perform(operation, reversed: true)
		}
		
		return copy.topCrateSequence
	}
	
	public func part2() async throws -> String {
		var copy = crates
		for operation in operations {
			copy.perform(operation, reversed: false)
		}
		
		return copy.topCrateSequence
	}
}


struct Crates: Hashable {
	init(lines: [String]) {
		var result: [[String]] = Array(repeating: [], count: 9)
		
		for line in lines {
			result[0].insert(line[1], at: 0)
			result[1].insert(line[5], at: 0)
			result[2].insert(line[9], at: 0)
			result[3].insert(line[13], at: 0)
			result[4].insert(line[17], at: 0)
			result[5].insert(line[21], at: 0)
			result[6].insert(line[25], at: 0)
			result[7].insert(line[29], at: 0)
			result[8].insert(line[33], at: 0)
		}
		
		for index in 0..<9 {
			result[index].removeAll { $0 == " " }
			result[index].removeAll { $0 == "" }
		}
		
		result.removeAll { $0.isEmpty }		

		self.stacks = result
	}
	
	private var stacks: [[String]]
	
	var topCrateSequence: String {
		stacks.map { $0.last ?? "" }.joined()
	}
	
	mutating func perform(_ operation: CraneOperation, reversed: Bool) {
		let removing = stacks[operation.from - 1].suffix(operation.count)
		stacks[operation.from - 1].removeLast(operation.count)
		if reversed {
			stacks[operation.to - 1].append(contentsOf: removing.reversed())
		} else {
			stacks[operation.to - 1].append(contentsOf: removing)
		}
	}
}

struct CraneOperation: Hashable {
	let from: Int
	let count: Int
	let to: Int
	
	init(_ line: String) {
		let splitted = line.components(separatedBy: " ")

		self.from = Int(splitted[3])!
		self.count = Int(splitted[1])!
		self.to = Int(splitted[5])!

	}
}
