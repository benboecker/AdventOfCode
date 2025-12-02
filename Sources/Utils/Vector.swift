//
//  File.swift
//  AdventOfCode
//
//  Created by Benjamin Böcker on 08.12.24.
//

import Foundation


public struct Vector2D: Hashable, AdditiveArithmetic, CustomStringConvertible {
	public static var zero: Vector2D = Vector2D(x: 0, y: 0)
	
	public var x: Int
	public var y: Int
	
	public var width: Int { x }
	public var height: Int { y }
	
	public init(x: Int, y: Int) {
		self.x = x
		self.y = y
	}
	
	public init(_ x: Int, _ y: Int) {
		self.x = x
		self.y = y
	}

	public init(width x: Int, height y: Int) {
		self.x = x
		self.y = y
	}
	
	public static func + (lhs: Vector2D, rhs: Vector2D) -> Vector2D {
		Vector2D(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
	}
	
	public static func - (lhs: Vector2D, rhs: Vector2D) -> Vector2D {
		Vector2D(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
	}
	
	func isWithin(_ vector: Vector2D) -> Bool {
		x >= 0 && y >= 0 && x < vector.width && y < vector.height
	}
	
	public var description: String {
		"(\(x)|\(y))"
	}
}


