//
//  File.swift
//  AdventOfCode
//
//  Created by Benjamin Böcker on 30.11.24.
//

import Foundation
import Utils


public struct Day1: Day {
	
	fileprivate let operations: [Operation]
	
	public init(_ input: Utils.Lines) {
		self.operations = input.map { Operation(value: $0) }
	}
	
	public func part1() async throws -> String {
		var dial = Dial()
		var password = 0
		
		for operation in operations {
			dial.addOperation(operation)
			
			if dial.value == 0 {
				password += 1
			}
		}
		
		return "\(password)"
	}
	
	public func part2() async throws -> String {
		var dial = Dial()
		
		for operation in operations {
			dial.addOperation(operation)
		}
		
		return "\(dial.zeroCrossed)"
	}
	
}


private extension Day1 {
	struct Dial {
		var value: Int = 50
		var zeroCrossed = 0
		
		mutating func addOperation(_ operation: Operation) {
			let steps = operation.value
			
			let (q, r) = steps.quotientAndRemainder(dividingBy: 100)
			zeroCrossed += abs(q)
			
			guard r != 0 else {
				return
			}
			
			let newUnwrapped = value + r
			
			// 2. Decide if we cross zero in this last partial turn
			if value != 0 && ((r > 0 && newUnwrapped >= 100) || (r < 0 && newUnwrapped <= 0)) {
				zeroCrossed += 1
			}
			
			value = (newUnwrapped % 100 + 100) % 100
		}
	}
	
	enum Operation: CustomDebugStringConvertible {
		case left(value: Int)
		case right(value: Int)
		
		init(value: String) {
			if value.starts(with: "L") {
				self = .left(value: Int(value.dropFirst())!)
			} else if value.starts(with: "R") {
				self = .right(value: Int(value.dropFirst())!)
			} else {
				fatalError("'\(value)' not valid")
			}
		}
		
		var value: Int {
			switch self {
			case .left(let value): -value
			case .right(let value): value
			}
		}
		
		var debugDescription: String {
			switch self {
			case .left(let value): "L\(value)"
			case .right(let value): "R\(value)"
			}
		}
	}
}
