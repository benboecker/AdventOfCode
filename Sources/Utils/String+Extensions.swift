//
//  File.swift
//  AdventOfCode
//
//  Created by Benjamin Böcker on 01.12.24.
//

import Foundation


public extension String {
	
	subscript(index: Int) -> String {
		guard index >= 0 && index < count else {
			return ""
		}
		
		let stringIndex = self.index(startIndex, offsetBy: index)
		return String(self[stringIndex])
	}
	
	subscript(range: Range<Int>) -> String {
		guard range.lowerBound >= 0 && range.upperBound < count else {
			return ""
		}
		var result = ""
		for index in range {
			result += self[index]
		}
		
		return result
	}
	
	var hasDifferentCharacters: Bool {
		let set = Set(self)
		return set.count == self.count
	}

	func getRegexMatches<RegexType>(of pattern: Regex<RegexType>) -> [String] {
		matches(of: pattern).compactMap { match in
			String(self[match.range])
		}
	}
}
