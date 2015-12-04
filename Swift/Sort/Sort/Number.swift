import Cocoa

// Number
// Created by Paul Kraft on 04.12.15.

class Number : CompareElement
{
	private let POWER = 9
	init()
	{
		super.init(Int(arc4random_uniform(UInt32(pow(Double(10),Double(POWER))))))
	}
}