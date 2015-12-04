import Cocoa
//
// UseCase.swift
// Created by Paul Kraft on 04.12.15.

class UseCase
{
	init()
	{
		var unsorted : [Number] = []
		var s : [[(name: String, array: [Number], time: Double)]] = []
		for _ in 1...4
		{
			let start : Double = Double(NSDate().timeIntervalSince1970*1000)
			for _ in 1...10000
			{
				unsorted.append(Number())
			}
			let end : Double = Double(NSDate().timeIntervalSince1970*1000) 
			let a = compareSortingAlgorithms(unsorted, (end - start))
			s.append(a)
			printComparedSortingAlgorithms(a, false)
		}
		
		for i in 0...Sort<Number>().sortingAlgorithms.count
		{
			var medianTime : Double = 0
			var times : Double = 0
			for j in 0..<s.count {
				medianTime += Double(s[j][i].time)
				times++
			}
			print(s[0][i].name + ":", Double(round(medianTime/(times))/1000), "s")
		}
		
	}
	
	
	func compareSortingAlgorithms(unsorted: [Number], _ initTime: Double) -> [(name: String, array: [Number], time: Double)] {
		var all : [(name: String, array: [Number], time: Double)] = []
		all.append(("Start", unsorted, initTime))
		let group = dispatch_group_create();
		for i in 0..<(Sort<Number>()).sortingAlgorithms.count {
			dispatch_group_async(group,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
				all.append( self.testAlg( (Sort<Number>()).sortingAlgorithms[i], unsorted))
			});
		}
		dispatch_group_wait(group, DISPATCH_TIME_FOREVER)
		return all
	}
	
	func printComparedSortingAlgorithms(info: [(name: String, array: [Number], time: Double)], _ printAllOut: Bool) {
		for i in 0..<info.count {
			print(info[i].name, "(", info[i].time, " ms )")
			if printAllOut {
				for j in 0..<info[i].array.count {
					print(info[i].array[j].description)
				}
			}
			else
			{
				if(i > 0 && i < info.count) {
					for j in 0..<info[i].array.count {
						if(!(info[1].array[j].description == info[i].array[j].description)) {
							print(info[i].array[j].description)
						}
						
					}
				}
			}
		}
	}
	
	func testAlg(sort: (([Number]) -> (name: String, array: [Number])), _ unsorted: [Number]) -> (name: String, array: [Number], time: Double) {
		let start = Double(NSDate().timeIntervalSince1970*1000)
		let sort = sort(unsorted)
		let end = Double(NSDate().timeIntervalSince1970*1000);
		return (sort.name, sort.array, (end - start))
	}
}
