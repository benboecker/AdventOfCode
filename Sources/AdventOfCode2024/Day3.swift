//
//  Day2.swift
//  AdventOfCode
//
//  Created by Benjamin Böcker on 30.11.24.
//

import Foundation
import Utils
import RegexBuilder

public struct Day3: Day {
	public init(_ input: Lines) {
		self.lines = input
	}
	
	private let lines: Lines
	
	public func part1() async throws -> String {
		let instructions = try getInstructions(from: lines)
		return instructions.computeResult(canDisable: false).output
	}
	
	public func part2() async throws -> String {
		let instructions = try getInstructions(from: lines)
		return instructions.computeResult(canDisable: true).output
	}
	
}


private extension Day3 {
	func getInstructions(from input: Lines) throws -> [Instruction] {
		let regex = /((mul\(\d*,\d*\))|(do\(\))|(don't\(\)))/
		
		return input
			.map { $0.getRegexMatches(of: regex) }
			.flatMap { $0 }
			.compactMap { Instruction(rawValue: $0) }
	}
	
	enum Instruction: RawRepresentable {
		case mul(x: Int, y: Int)
		case `do`
		case dont
		
		init?(rawValue: String) {
			if rawValue.starts(with: "mul") {
				let values = rawValue
					.dropFirst(4)
					.dropLast()
					.split(separator: ",")
					.compactMap { Int($0) }
				
				self = .mul(x: values[0], y: values[1])
			} else if rawValue.starts(with: "do()"){
				self = .do
			} else if rawValue.starts(with: "don't()"){
				self = .dont
			} else {
				return nil
			}

		}
		
		var rawValue: String {
			switch self {
			case .do: "do()"
			case .dont: "don't()"
			case let .mul(x, y): "mul(\(x),\(y))"
			}
		}
		
		typealias RawValue = String
		
		var result: Int {
			switch self {
			case .mul(let x, let y):
				x * y
			default:
				0
			}
		}
	}
}

extension [Day3.Instruction] {
	func computeResult(canDisable: Bool) -> Int {
		var mulEnabled = true
		var result = 0
		
		for instruction in self {
			switch instruction {
			case .mul where mulEnabled:
				result += instruction.result
			case .do:
				mulEnabled = true
			case .dont where canDisable:
				mulEnabled = false
			default:
				break
			}
		}
		
		return result
	}
}
