//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 03.12.23.
//

import Foundation
import Utils


public enum Day3 { }


public extension Day3 {
	static func part1() -> Int {
		getRucksacks()
			.reduce(0) {
				$0 + $1.priority
			}
	}
	
	static func part2() -> Int {
		0
	}
}

private extension Day3 {
	static func getRucksacks() -> [Rucksack] {
		lines(in: "day3", bundle: .module)
			.filter { !$0.isEmpty }
			.map { Rucksack(from: $0) }
	}
}

private struct Rucksack {
	let compOne: String
	let compTwo: String
	
	init(from string: String) {
		compOne = String(string.prefix(string.count / 2))
		compTwo = String(string.suffix(string.count / 2))
	}
	
	var priority: Int {
		(characters.firstIndex(of: sameElement)?.utf16Offset(in: characters) ?? 0) + 1
	}
	
	private var sameElement: Character {
		for characterOne in compOne {
			for characterTwo in compTwo where characterOne == characterTwo {
				return characterTwo
			}
		}
		
		fatalError()
	}
	
	private let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
}



