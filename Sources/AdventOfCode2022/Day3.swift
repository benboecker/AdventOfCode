//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 03.12.23.
//

import Foundation
import Utils


public struct Day3: Day {
	public init(_ input: Lines) {
		self.rucksacks = input
			.filter { !$0.isEmpty }
			.map { Rucksack(from: $0) }
	}
	
	private let rucksacks: [Rucksack]
	
	public func part1() async throws -> String {
		rucksacks
			.reduce(0) {
				$0 + $1.priority
			}
			.formatted(.number.grouping(.never))
	}
	
	public func part2() async throws -> String {
		var index = 2
		var priority = 0
		
		while index < rucksacks.count {
			let rucksack1 = Set(rucksacks[index - 2].contents)
			let rucksack2 = Set(rucksacks[index - 1].contents)
			let rucksack3 = Set(rucksacks[index - 0].contents)
			
			let sameElements = rucksack1
				.intersection(rucksack2)
				.intersection(rucksack3)
			
			priority += sameElements.first!.priority
			
			index += 3
		}
		
		
		return priority.formatted(.number.grouping(.never))
	}
}


private struct Rucksack: Hashable {
	let compOne: String
	let compTwo: String
	
	var contents: String {
		compOne + compTwo
	}
	
	init(from string: String) {
		compOne = String(string.prefix(string.count / 2))
		compTwo = String(string.suffix(string.count / 2))
	}
	
	var priority: Int {
		sameElement.priority
	}
	
	private var sameElement: Character {
		for characterOne in compOne {
			for characterTwo in compTwo where characterOne == characterTwo {
				return characterTwo
			}
		}
		
		fatalError()
	}
}


extension String.Element {
	var priority: Int {
		(characters.firstIndex(of: self)?.utf16Offset(in: characters) ?? 0) + 1
	}
	private var characters: String { "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" }
}
