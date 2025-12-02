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
}
