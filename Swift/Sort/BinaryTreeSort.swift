//
//  BinaryTreeSort.swift
//  Sort
//
//  Created by Paul Kraft on 21.12.15.
//  Copyright © 2015 Paul Kraft. All rights reserved.
//

import Cocoa

func binaryTreeSort<T: Comparable>(unsorted: [T]) -> (name: String, array: [T]) {
    return ("BinaryTreeSort", binaryTreeSortRecursive(unsorted))
}

private func binaryTreeSortRecursive<T: Comparable>(unsorted: [T]) -> [T] {
    return BinaryTree<T>(unsorted).array()
}

private class BinaryTree<T: Comparable> {
    private var root: binaryTreeElement<T>
    
    convenience init(_ array: [T]) {
        self.init(binaryTreeLeaf<T>())
        for i in 0..<array.count {
            root = root.insert(array[i])
        }
    }
    
    init(_ root: binaryTreeElement<T>) {
        self.root = root
    }
    
    func insert(newData: T) {
        root = root.insert(newData)
    }
    
    func array() -> [T] {
        return root.array()
    }
}

private class binaryTreeElement<T:Comparable> {
    func insert(newData: T) -> binaryTreeElement<T> {
        return binaryTreeNode<T>(newData)
    }
    
    func array() -> [T] {
        return []
    }
}

private class binaryTreeNode<T: Comparable> : binaryTreeElement<T> {
    let data : T
    var left : binaryTreeElement<T>
    var right: binaryTreeElement<T>
    
    convenience init(_ newData: T) {
        self.init(newData, left: binaryTreeLeaf<T>(), right: binaryTreeLeaf<T>())
    }
    
    init(_ newData: T, left: binaryTreeElement<T>, right: binaryTreeElement<T>) {
        self.data = newData
        self.left = left
        self.right = right
    }
    
    override func insert(newData: T) -> binaryTreeElement<T> {
        if newData < self.data { left  =  left.insert(newData) }
        else                   { right = right.insert(newData) }
        return self
    }
    
    override func array() -> [T] {
        var res = left.array()
        res.append(data)
        return res + right.array()
    }
}

private class binaryTreeLeaf<T: Comparable> : binaryTreeElement<T> {}
























