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
    private var root: BinaryTreeElement<T>?
    
    convenience init(_ array: [T]) {
        self.init(nil)
        for i in array {
            insert(i)
        }
    }
    
    init(_ root: BinaryTreeElement<T>?) {
        self.root = root
    }
    
    func insert(newData: T) {
        if root == nil { root = BinaryTreeElement(newData) }
        else           { root!.insert(newData) }
    }
    
    func array() -> [T] {
        if root == nil { return [] }
        return root!.array()
    }
    
    func dot() -> String {
        var res = "\tdigraph g { \n\t\tgraph [ordering = out] \n"
        if root != nil { res += "\(root!.dot())"}
        return  res + "\t}\n"
    }
}


private class BinaryTreeElement<T: Comparable> {
    private let data: T
    private var  left: BinaryTreeElement<T>?
    private var right: BinaryTreeElement<T>?
    
    convenience init(_ newData: T) {
        self.init(newData, left: nil, right: nil)
    }
    
    init(_ newData: T, left: BinaryTreeElement<T>?, right: BinaryTreeElement<T>?) {
        self.data = newData
        self.left = left
        self.right = right
    }
    
    func insert(newData: T) {
        if newData < self.data {
            if  left == nil { left = BinaryTreeElement<T>(newData) }
            else            { left!.insert(newData) }
        }
        else {
            if right == nil { right = BinaryTreeElement<T>(newData) }
            else            { right!.insert(newData) }
        }
    }
    
    func array() -> [T] {
        var res: [T] = []
        if left  != nil { res +=  left!.array() }
        res.append(data)
        if right != nil { res += right!.array() }
        return res
    }
    
    func dot() -> String {
        var a = ""
        if  left != nil { a += "\t\t\(self.data) -> \( left!.data) [label=left] \n" }
        if right != nil { a += "\t\t\(self.data) -> \(right!.data) [label=right]\n" }
        
        if  left != nil { a +=  left!.dot() }
        if right != nil { a += right!.dot() }
        return a
    }
}




















