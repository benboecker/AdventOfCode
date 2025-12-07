//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 02.12.23.
//

import Foundation



public struct Lines: Hashable {
	public init(fileName: String, fileExtension: String = "txt", bundle: Bundle) {
		do {
			let file = try String(contentsOf: bundle.url(forResource: fileName, withExtension: fileExtension)!)
			self.lines = file.components(separatedBy: .newlines).dropLast()
		} catch {
			print("\(error)")
			self.lines = []
		}
		
	}
	
	public let lines: [String]
	
	public var count: Int {
		lines.count
	}
	
	public subscript(_ index: Int) -> String {
		lines[index]
	}
}

extension Lines: Sequence {
	public func makeIterator() -> LinesIterator {
		return LinesIterator(self)
	}
}


public func lines(in file: String, fileExtension: String = "txt", bundle: Bundle) -> [String] {
	let file = try! String(contentsOf: bundle.url(forResource: file, withExtension: fileExtension)!)
	return file.components(separatedBy: .newlines)		
}


public class LinesIterator: IteratorProtocol {
	
	private let lines: Lines
	private var index = 0
	
	init(_ lines: Lines) {
		self.lines = lines
	}
	
	public func next() -> String? {
		defer {index += 1 }
		return index < lines.count ? lines[index] : nil
	}
}

