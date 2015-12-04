import Cocoa

// Sort
// Created by Paul Kraft on 03.12.15.

class Sort<T : CompareElement>
{
	var sortingAlgorithms : [([T] -> (String, [T]))] = []
	let MAX_THREADS = 8
	
	init()
	{
		sortingAlgorithms = [
			//bubbleSort,
			//insertionSort,
			//quickSort,
			quickSortRandom,
			quickSortThreaded,
            quickSortRandomThreaded,
            quickSortArray
			//quickSortRandomArray
			//quickSortRandomThreadedArray
		]
	}
	
	func insertionSort(unsorted: [T]) -> (String, [T]) {
		var sorted : [T] = []
		for i in 0..<unsorted.count {
			sorted.append(unsorted[i]);
		}
		for i in 0..<sorted.count {
			var k = 0
			while(k < i && sorted[k] < sorted[i]) { k++ }
			sorted.insert(sorted.removeAtIndex(i), atIndex: k)
		}
		return ("InsertionSort", sorted)
	}
	
	func quickSort(unsorted: [T]) -> (name: String, array: [T]) {
		var l : [T] = []
		var r : [T] = []
		if unsorted.count > 0 {
			let pivot = unsorted[0]
			for i in 1..<unsorted.count {
				if unsorted[i] < pivot { l.append(unsorted[i]) }
				else { r.append(unsorted[i]) }
			}
			r = self.quickSort(r).array
			l = self.quickSort(l).array
			l.append(pivot)
		}
		return ("QuickSort", l + r)
	}
	
	func quickSortThreaded(unsorted: [T]) -> (name: String, array: [T]) {
		return ("QuickSortThreaded", quickSortThreadedRecursive(unsorted, 0))
	}
	
	func quickSortThreadedRecursive(unsorted: [T], _ depth: Int) -> [T]
	{
		if unsorted.count == 0 { return [] }
		var l : [T] = []
		var r : [T] = []
		let pivot = unsorted[0]
		for i in 1..<unsorted.count {
			if unsorted[i] < pivot { l.append(unsorted[i]) }
			else { r.append(unsorted[i]) }
		}
		if depth < MAX_THREADS/2 {
			let group = dispatch_group_create();
			dispatch_group_async(group,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
				r = self.quickSortThreadedRecursive(r, depth + 1)
			});

			dispatch_group_async(group,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
				l = self.quickSortThreadedRecursive(l, depth + 1)
			});
			
			dispatch_group_wait(group, DISPATCH_TIME_FOREVER)
		}
		else {
			r = self.quickSortThreadedRecursive(r, depth + 1)
			l = self.quickSortThreadedRecursive(l, depth + 1)
		}
		l.append(pivot)
		return l + r
	}

	
	func quickSortRandom(unsorted: [T]) -> (name: String, array: [T]) {
		var l : [T] = []
		var r : [T] = []
		if unsorted.count > 0 {
			let pivotIndex = Int(arc4random_uniform(UInt32(unsorted.count)))
			let pivot = unsorted[pivotIndex]
			for i in 0..<pivotIndex {
				if unsorted[i] < pivot { l.append(unsorted[i]) }
				else { r.append(unsorted[i]) }
			}
			for i in pivotIndex+1..<unsorted.count {
				if unsorted[i] < pivot { l.append(unsorted[i]) }
				else { r.append(unsorted[i]) }
			}
			r = self.quickSortRandom(r).array
			l = self.quickSortRandom(l).array
			l.append(pivot)
		}
		return ("QuickSortRandom", l + r)
	}
	
	func quickSortRandomThreaded(unsorted: [T]) -> (name: String, array: [T]) {
		return ("QuickSortRandomThreaded", quickSortRandomThreadedRecursive(unsorted, 0))
	}
	
	func quickSortRandomThreadedRecursive(unsorted: [T], _ depth : Int) -> [T] {
		if unsorted.count == 0 { return [] }
		var l : [T] = []
		var r : [T] = []
        let pivotIndex = Int(arc4random_uniform(UInt32(unsorted.count)))
		let pivot = unsorted[pivotIndex]
		for i in 0..<unsorted.count {
			if (i != pivotIndex) {
				if unsorted[i] < pivot { 
					l.append(unsorted[i]) 
				}
				else {
					r.append(unsorted[i])
				}
			}
		}
		if depth < MAX_THREADS/2 {	
			let group = dispatch_group_create();
			dispatch_group_async(group,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
				r = self.quickSortRandomThreadedRecursive(r, depth + 1)
			});

			dispatch_group_async(group,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
				l = self.quickSortRandomThreadedRecursive(l, depth + 1)
			});
			
			dispatch_group_wait(group, DISPATCH_TIME_FOREVER)
		}
		else
		{
			r = self.quickSortRandomThreadedRecursive(r, depth)
			l = self.quickSortRandomThreadedRecursive(l, depth)
		}
		l.append(pivot)
		return l + r
	}
	
	func quickSortRandomThreadedArray(unsorted: [T]) -> (name: String, array: [T]) {
		var sorted : [T] = []
		for i in 0..<unsorted.count {
			sorted.append(unsorted[i])
		}
		return ("QuickSortRandomThreadedArray", quickSortRandomThreadedArrayRecursive(sorted, 0, unsorted.count))
	}
	
	private func quickSortRandomThreadedArrayRecursive(var sorted: [T], _ start : Int, _ end: Int) -> [T]
	{
		if (end-start) > 0 {
			var pivotIndex = Int(arc4random_uniform(UInt32(end - start))) + start
            dispatch_barrier_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
                let pivot = sorted[pivotIndex]
                for i in start..<pivotIndex {
                    if pivot < sorted[i] {
                        if(pivotIndex == end) { sorted.append(sorted.removeAtIndex(i)) }
                        else { sorted.insert(sorted.removeAtIndex(i), atIndex: pivotIndex) }
                        pivotIndex--
                    }
                }
                for i in pivotIndex+1..<sorted.count {
                    if sorted[i] < pivot {
                        sorted.insert(sorted.removeAtIndex(i), atIndex: start)
                        pivotIndex++
                    }
                }
            });
            if(end-start) > 20
            {
                let group = dispatch_group_create();
                dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
                    self.quickSortRandomThreadedArrayRecursive(sorted, start, pivotIndex)
                });
            
                dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
                    self.quickSortRandomThreadedArrayRecursive(sorted, pivotIndex + 1, end)
                });
                dispatch_group_wait(group, DISPATCH_TIME_FOREVER)
            }
            else
            {
                self.quickSortRandomThreadedArrayRecursive(sorted, start, pivotIndex)
                self.quickSortRandomThreadedArrayRecursive(sorted, pivotIndex + 1, end)
            }
		}
		return sorted
	}
	
	func quickSortRandomArray(unsorted: [T]) -> (name: String, array: [T]) {
		var sorted : [T] = []
		for i in 0..<unsorted.count {
			sorted.append(unsorted[i])
		}
		return ("QuickSortRandomArray", quickSortRandomArrayRecursive(sorted, 0, unsorted.count))
	}
	
	private func quickSortRandomArrayRecursive(var sorted: [T], _ start : Int, _ end: Int) -> [T]
	{
		if (end-start) > 0 {
			var pivotIndex = Int(arc4random_uniform(UInt32(end - start))) + start
			let pivot = sorted[pivotIndex]
            for i in start..<pivotIndex {
                if pivot < sorted[i] {
                    if(pivotIndex == end) { sorted.append(sorted.removeAtIndex(i)) }
                    else { sorted.insert(sorted.removeAtIndex(i), atIndex: pivotIndex + 1) }
                    pivotIndex--
                }
            }
            for i in pivotIndex+1..<sorted.count {
                if sorted[i] < pivot {
                    sorted.insert(sorted.removeAtIndex(i), atIndex: start)
                    pivotIndex++
                }
            }

			self.quickSortRandomArrayRecursive(sorted, start, pivotIndex)
			self.quickSortRandomArrayRecursive(sorted, pivotIndex + 1, end)
		}
		return sorted
	}
    
    func quickSortArray(unsorted: [T]) -> (name: String, array: [T]) {
        var sorted : [T] = []
        for i in 0..<unsorted.count {
            sorted.append(unsorted[i])
        }
        return ("QuickSortArray", quickSortArrayRecursive(sorted, 0, unsorted.count))
    }
    
    private func quickSortArrayRecursive(var sorted: [T], _ start : Int, _ end: Int) -> [T]
    {
        if end > start {
            var pivotIndex = Int(arc4random_uniform(UInt32(end - start))) + start
            var pivot = sorted[pivotIndex]
            let la1 = [] + sorted[start..<pivotIndex]
            let ra1 = [] + sorted[pivotIndex+1..<end]
            printQuickSortStep(la1, pivot, ra1)
			var l = start
			var r = end-1
			while l < r && l <= pivotIndex && r >= pivotIndex {
				while (l <= pivotIndex && sorted[l] < pivot) { l++ }
				while (r >= pivotIndex  && pivot < sorted[r]) { r-- }
				if (l <= pivotIndex && r >= pivotIndex && r != l) {
                    let tmp = sorted[r]
                    sorted[r] = sorted[l]
                    sorted[l] = tmp
                    if(l == pivotIndex) {
                        pivotIndex = r
                        pivot = sorted[pivotIndex]
                    }
                    if(r == pivotIndex) {
                        pivotIndex = l
                        pivot = sorted[pivotIndex]
                    }
                }
			}
            
            let la2 = [] + sorted[start..<pivotIndex]
            let ra2 = [] + sorted[pivotIndex+1..<end]
            printQuickSortStep(la2, pivot, ra2)
            
            self.quickSortArrayRecursive(sorted, start, pivotIndex)
            self.quickSortArrayRecursive(sorted, pivotIndex + 1, end)
        }
        return sorted
    }

    private func printQuickSortStep(left: [T], _ pivot: T, _ right: [T]) {
        for i in 0..<left.count {
            print(" ", left[i].description)
        }
        print(pivot.description)
        for i in 0..<right.count {
            print(" ", right[i].description)
        }
        print("------------------------------------\n")
    }
	
    func bubbleSort(unsorted: [T]) -> (String, [T])
	{
		var sorted : [T] = []
		for i in 0..<unsorted.count{
			sorted.append(unsorted[i]);
		}
		var didChange = false
		repeat
		{
			didChange = false
			for i in 0..<sorted.count - 1 {
				if sorted[i+1] < sorted[i] {
					didChange = true
					sorted.insert(sorted.removeAtIndex(i+1), atIndex: i);
				}
			}
		}
			while(didChange)
		return ("BubbleSort", sorted)
	}
	
}
