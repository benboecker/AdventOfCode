//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 05.12.23.
//

import Foundation
import Utils


public struct Day5: Day {
	public init(_ input: Utils.Lines) {
		self.lines = input
	}
	
	let lines: Lines
	
	public func part1() async throws -> String {
		let (seeds, maps) = parsePart1Input()
		
		let locations = seeds.map { seed in
			var mapped = seed
			for map in maps {
				mapped = map.map(mapped)
			}
			return mapped
		}
		
		return "\(locations.min() ?? -1)"

	}
	
	public func part2() async throws -> String {
		let (seedRanges, maps) = parsePart2Input()
		
		var location = Int.max
		for (index, range) in seedRanges.enumerated() {
			print("mapping over range \(index + 1), containing \(range.count) seeds")
			
			for (index, seed) in range.enumerated() {
				if index.isMultiple(of: 1_000_000) {
					print("\(Float(index) / Float(range.count) * 100.0)% done")
				}
				var mapped = seed
				for map in maps {
					mapped = map.map(mapped)
				}
				location = min(location, mapped)
			}
		}
		
		return "\(location)"
	}
}



private extension Day5 {
	
	func parsePart1Input() -> (seeds: Set<Int>, maps: [Map]) {
		let splitted = lines[0].components(separatedBy: "\n\n")
		let seeds = splitted[0]
			.components(separatedBy: ":")[1]
			.components(separatedBy: .whitespaces)
			.compactMap { Int($0) }
		
		let maps = Array(splitted.dropFirst()).map {
			let lines = $0.components(separatedBy: .newlines)
			let mappings = Array(lines.dropFirst()).compactMap { line -> Mapping? in
				guard !line.isEmpty else { return nil }
				return Mapping(from: line)
			}
			return Map(mappings: Set(mappings))
		}
		
		return (seeds: Set(seeds), maps: maps)
	}
	
	func parsePart2Input() -> (seeds: Set<Range<Int>>, maps: [Map]) {
		let splitted = lines[0].components(separatedBy: "\n\n")
		
		let allValues = splitted[0]
			.components(separatedBy: ":")[1]
			.components(separatedBy: .whitespaces)
			.compactMap { Int($0) }
		
		print("Lets zip")
		let zipped = zip(
			allValues.enumerated().filter { $0.offset.isMultiple(of: 2) }.map(\.element),
			allValues.enumerated().filter { !$0.offset.isMultiple(of: 2) }.map(\.element)
		)
		
		print("Lets map the zip")
		let ranges = zipped.map { $0 ..< $0 + $1 }
		
		let maps = Array(splitted.dropFirst()).map {
			let lines = $0.components(separatedBy: .newlines)
			let mappings = Array(lines.dropFirst()).compactMap { line -> Mapping? in
				guard !line.isEmpty else { return nil }
				return Mapping(from: line)
			}
			return Map(mappings: Set(mappings))
		}
		
		return (seeds: Set(ranges), maps: maps)
	}

	struct Map {
		let mappings: Set<Mapping>
		
		func map(_ number: Int) -> Int {
			for mapping in mappings {
				if let mapped = mapping.map(number) {
					return mapped
				}
			}
			
			return number
		}
	}
	
	struct Mapping: Hashable {
		private let sourceRange: Range<Int>
		private let destinationRange: Range<Int>
		
		init(from line: String) {
			assert(!line.isEmpty, "Line for Mapping should not be empty!")
			
			let splitted = line.components(separatedBy: .whitespaces)
			let source = Int(splitted[1])!
			let destination = Int(splitted[0])!
			let length = Int(splitted[2])!
			
			self.sourceRange = source ..< source + length
			self.destinationRange = destination ..< destination + length
		}
		
		func map(_ number: Int) -> Int? {
			guard sourceRange.contains(number) else { return nil }
			let index = number - sourceRange.startIndex
			let destinationIndex = destinationRange.startIndex.advanced(by: index)
			let mapped = destinationRange[destinationIndex]
			return mapped
		}
	}
}
