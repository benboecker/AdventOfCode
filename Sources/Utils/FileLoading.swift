//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 02.12.23.
//

import Foundation


public func lines(in file: String, fileExtension: String = "txt", bundle: Bundle) -> [String] {
	let file = try! String(contentsOf: bundle.url(forResource: file, withExtension: fileExtension)!)
	return file.components(separatedBy: .newlines)		
}



