//
//  Day6.swift
//  AdventOfCode
//
//  Created by Benjamin Böcker on 06.12.24.
//

import Foundation
import Utils
import RegexBuilder


public class Day9: Day {
	public required init(_ input: Lines) {
		self.blocks = Self.getBlocks(from: input[0])
	}

	private var blocks: [Block]
	
	public func part1() async throws -> String {
		var firstEmptyIndex = blocks.firstEmptyIndex() ?? 0
		var lastFileIndex = blocks.lastFileIndex() ?? 0
		
		
		while firstEmptyIndex < lastFileIndex{
			blocks[firstEmptyIndex] = blocks[lastFileIndex]
			blocks[lastFileIndex] = .empty
			
			firstEmptyIndex = blocks.firstEmptyIndex() ?? 0
			lastFileIndex = blocks.lastFileIndex() ?? 0
		}
		
//		return "6359213660505"
		return blocks.checksum().output
	}
	
	public func part2() async throws -> String {
		return ""
	}
	
	private static func getBlocks(from input: String) -> [Block] {
		var blocks: [Block] = []
		var currentID = 0
		
		for (index, value_) in input.enumerated() {
			guard let value = Int(String(value_)) else { continue }
			
			if index.isMultiple(of: 2) {
				blocks.append(contentsOf: Array.init(repeating: .file(id: currentID), count: value))
				currentID += 1
			} else {
				blocks.append(contentsOf: Array.init(repeating: .empty, count: value))
			}
		}
				
		return blocks
	}
}

extension Day9 {
	enum Block: CustomStringConvertible, Hashable {
		case empty
		case file(id: Int)
		
		var isEmpty: Bool {
			switch self {
			case .empty: true
			default: false
			}
		}
		var notEmpty: Bool {
			!isEmpty
		}
		
		var id: Int? {
			switch self {
			case .file(id: let id): id
			default: nil
			}
		}
		
		var description: String {
			switch self {
			case .empty: "."
			case .file(let id): "\(id)"
			}
		}
	}
}


extension [Day9.Block] {
	func firstEmptyIndex() -> Int? {
		firstIndex { $0.isEmpty }
	}
	
	func lastFileIndex() -> Int? {
		lastIndex { $0.notEmpty }
	}
	
	func printDescription() {
		print(self.map(\.description).joined(separator: ""))
	}
	
	func checksum() -> Int {
		enumerated().reduce(0) { $0 + ($1.element.id ?? 0) * $1.offset }
	}
}
