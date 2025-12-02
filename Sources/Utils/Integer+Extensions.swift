//
//  File.swift
//  AdventOfCode
//
//  Created by Benjamin Böcker on 03.12.24.
//

import Foundation


public extension Int {
	var output: String {
		self.formatted(.number.grouping(.never))
	}
	
	
	var digitSum: Int {
		let str = "\(self)"
		
		return str.reduce(0) {
			$0 + (Int(String($1)) ?? 0)
		}
	}
	
}
