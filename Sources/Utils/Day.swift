//
//  Day.swift
//  AdventOfCode
//
//  Created by Benjamin Böcker on 01.12.24.
//

import Foundation


public protocol Day {
	init(_ input: Lines)
	
	func part1() async throws -> String
	func part2() async throws -> String
}

public extension Day {
	func printDay(_ index: Int) async throws {
		print("")
		print("### Day \(index + 1) ####################")
		print("Part 1 - \(try await part1())")
		print("Part 2 - \(try await part2())")
	}
}


public enum AdventError: Error, CustomStringConvertible {
	case generic(String)
	
	public var description: String {
		switch self {
		case .generic(let message): message
		}
	}
}
