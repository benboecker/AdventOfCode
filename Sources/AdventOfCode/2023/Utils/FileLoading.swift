//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 02.12.23.
//

import Foundation


func lines(in file: String, fileExtension: String = "txt") -> [String] {
	let file = try! String(contentsOf: Bundle.module.url(forResource: file, withExtension: fileExtension)!)
	return file.components(separatedBy: .newlines)
}



