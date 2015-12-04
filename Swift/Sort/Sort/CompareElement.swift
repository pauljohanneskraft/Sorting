import Cocoa

// CompareElement
// Created by Paul Kraft on 04.12.15.

class CompareElement : Comparable
{
	let description : Int
	init(_ desc : Int)
	{
		description = desc
	}
}

func ==(x: CompareElement, y: CompareElement) -> Bool {
	if x.description == y.description { return true }
	return false
}

func <(x: CompareElement, y: CompareElement) -> Bool {
	if x.description < y.description { return true }
	return false
}
