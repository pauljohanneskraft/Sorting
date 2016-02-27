//
//  BinaryTreeCompositeSort.swift
//  Sort
//
//  Created by Paul Kraft on 21.12.15.
//  Copyright © 2015 Paul Kraft. All rights reserved.
//

import Cocoa

func binaryTreeCompositeSort<T: Comparable>(unsorted: [T]) -> (name: String, array: [T]) {
    return ("BinaryTreeCompositeSort", binaryTreeCompositeSortRecursive(unsorted))
}

private func binaryTreeCompositeSortRecursive<T: Comparable>(unsorted: [T]) -> [T] {
    return BinaryTreeComposite<T>(unsorted).array()
}

private class BinaryTreeComposite<T: Comparable> {
    private var root: BinaryTreeCompositeElement<T>
    
    convenience init(_ array: [T]) {
        self.init(BinaryTreeCompositeLeaf<T>())
        for i in array {
            root = root.insert(i)
        }
        //print("\n\tcomposite\n", dot())
    }
    
    init(_ root: BinaryTreeCompositeElement<T>) {
        self.root = root
    }
    
    func insert(newData: T) {
        root = root.insert(newData)
    }
    
    func array() -> [T] {
        return root.array()
    }
    
    func dot() -> String {
        return "\tdigraph g { \n\t\tgraph [ordering = out] \n\(root.dot()) \t}\n"
    }
}

private class BinaryTreeCompositeElement<T:Comparable> {
    private var data : T? { return nil }
    var  left: BinaryTreeCompositeElement<T> { get { return self } set { } }
    var right: BinaryTreeCompositeElement<T> { get { return self } set { } }
    
    func insert(newData: T) -> BinaryTreeCompositeElement<T> {
        return BinaryTreeCompositeNode<T>(newData)
    }
    
    func array() -> [T] {
        return []
    }
    
    func dot() -> String {
        return ""
    }
    
    func isNode() -> Bool {
        return false
    }
}

private class BinaryTreeCompositeNode<T: Comparable> : BinaryTreeCompositeElement<T> {
    private let dataObject: T
    private var  leftElement: BinaryTreeCompositeElement<T>
    private var rightElement: BinaryTreeCompositeElement<T>
    override var  left: BinaryTreeCompositeElement<T> { get { return  leftElement } set {  leftElement = newValue } }
    override var right: BinaryTreeCompositeElement<T> { get { return rightElement } set { rightElement = newValue } }
    override private var data : T? { return dataObject }
    
    convenience init(_ newData: T) {
        self.init(newData, left: BinaryTreeCompositeLeaf<T>(), right: BinaryTreeCompositeLeaf<T>())
    }
    
    init(_ newData: T, left: BinaryTreeCompositeElement<T>, right: BinaryTreeCompositeElement<T>) {
        self.dataObject = newData
        self.leftElement = left
        self.rightElement = right
    }
    
    override func insert(newData: T) -> BinaryTreeCompositeElement<T> {
        if newData < self.data { left  =  left.insert(newData) }
        else                   { right = right.insert(newData) }
        return self
    }
    
    override func array() -> [T] {
        var res = left.array()
        res.append(data!)
        return res + right.array()
    }
    
    override func dot() -> String {
        var a = ""
        if  left.isNode() { a += "\t\t\(self.data!) -> \( left.data!) [label=left] \n" }
        if right.isNode() { a += "\t\t\(self.data!) -> \(right.data!) [label=right]\n" }
        
        a += left.dot()
        a += right.dot()
        return a
    }
    
    override func isNode() -> Bool {
        return true
    }
}

private class BinaryTreeCompositeLeaf<T: Comparable> : BinaryTreeCompositeElement<T> {}