//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 03.12.23.
//

import Foundation

public extension Array {
	
	subscript(safe index: Int) -> Element? {
		guard index >= 0, index < count else {
			return nil
		}
		
		return self[index]
	}
	
	var hasContent: Bool { !isEmpty }
}
