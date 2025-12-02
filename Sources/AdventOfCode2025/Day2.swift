//
//  File.swift
//  AdventOfCode
//
//  Created by Benjamin Böcker on 30.11.24.
//

import Foundation
import Utils


public struct Day2: Day {
		
	public init(_ input: Utils.Lines) {
		ranges = input[0]
			.split(separator: ",")
			.map { IDRange(value: String($0)) }
		
	}
	
	fileprivate let ranges: [IDRange]
	
	public func part1() async throws -> String {
		let invalidIDs = ranges
			.map { $0.getInvalidIDsPart1() }
			.filter(\.hasContent)
				
		let result = invalidIDs.reduce(0) {
			$0 + $1.reduce(0, +)
		}
		
		return "\(result)"
	}
	
	public func part2() async throws -> String {
		let invalidIDs = ranges
			.map { $0.getInvalidIDsPart2() }
			.filter(\.hasContent)
		
		let result = invalidIDs.reduce(0) {
			$0 + $1.reduce(0, +)
		}
		
		return "\(result)"
	}
	
}


fileprivate struct IDRange {
	init(value: String) {
		let splitted = value
			.split(separator: "-")
			.compactMap { Int(String($0)) }
		
		let range = splitted[0]...splitted[1]
				
		var _ids: [Int] = []
		for id in range {
			_ids.append(Int(id))
		}
		ids = _ids
	}
	
	let ids: [Int]
		
	func getInvalidIDsPart1() -> [Int] {
		ids.filter { id in
			let str = "\(id)"
			
			guard str.count.isMultiple(of: 2) else {
				return false
			}
			
			let left = str.prefix(str.count / 2)
			let right = str.suffix(str.count / 2)
			
			return left == right
		}
	}
	
	func getInvalidIDsPart2() -> [Int] {
		ids.filter { id in
			let str = "\(id)"
			
			let res = (str + str)
				.dropFirst()
				.dropLast()
				.contains(str)
			
			return res
		}
	}
}


