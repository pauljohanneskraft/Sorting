//
//  AVLBinaryTreeSort.swift
//  Sort
//
//  Created by Paul Kraft on 21.12.15.
//  Copyright © 2015 kraft. All rights reserved.
//

import Cocoa

//just to illustrate how an average-level-tree looks like, when used for sorting
//for sorting, it's less efficient than BinaryTreeSort, because a rotation takes a long time compared to a a-little-longer path.

func avlBinaryTreeSort<T: Comparable>(unsorted: [T]) -> (name: String, array: [T]) {
    return ("AVLBinaryTreeSort", avlBinaryTreeSortRecursive(unsorted))
}

private func avlBinaryTreeSortRecursive<T: Comparable>(unsorted: [T]) -> [T] {
    return AVLBinaryTree<T>(unsorted).array()
}

private class AVLBinaryTree<T: Comparable> {
    private var root: AVLBinaryTreeElement<T>
    
    convenience init(_ array: [T]) {
        self.init(AVLBinaryTreeLeaf<T>())
        for i in 0..<array.count {
            root = root.insert(array[i])
            //print(dot())
        }
    }
    
    init(_ root: AVLBinaryTreeElement<T>) {
        self.root = root
    }
    
    func dot() -> String {
        return "\tdigraph g { \n\t\tgraph [ordering = out] \n\(root.dot()) \t}\n"
    }
    
    func insert(newData: T) {
        root = root.insert(newData)
    }
    
    func array() -> [T] {
        return root.array()
    }
}

private class AVLBinaryTreeElement<T:Comparable> {
    init() {
        balance = -1
    }
    var  left: AVLBinaryTreeElement<T> { get { return self } set { } }
    var right: AVLBinaryTreeElement<T> { get { return self } set { } }

    func insert(newData: T) -> AVLBinaryTreeElement<T> {
        return AVLBinaryTreeNode<T>(newData)
    }
    
    func dot() -> String {
        return ""
    }
    
    func array() -> [T] {
        return []
    }
    
    func isNode() -> Bool {
        return false
    }
    
    private var data : T? { return nil }
    private var balance: Int
}

private class AVLBinaryTreeNode<T: Comparable> : AVLBinaryTreeElement<T> {
    private let dataObject: T
    private var  leftElement: AVLBinaryTreeElement<T>
    private var rightElement: AVLBinaryTreeElement<T>
    override var  left: AVLBinaryTreeElement<T> { get { return  leftElement } set {  leftElement = newValue } }
    override var right: AVLBinaryTreeElement<T> { get { return rightElement } set { rightElement = newValue } }
    override private var data : T? { return dataObject }
    
    convenience init(_ newData: T) {
        self.init(newData, left: AVLBinaryTreeLeaf<T>(), right: AVLBinaryTreeLeaf<T>())
    }
    
    init(_ newData: T, left: AVLBinaryTreeElement<T>, right: AVLBinaryTreeElement<T>) {
        self.dataObject = newData
        self.leftElement = left
        self.rightElement = right
        super.init()
        self.balance = max(left.balance, right.balance) + 1
    }
    
    override func insert(newData: T) -> AVLBinaryTreeElement<T> {
        if newData < self.data { left  =  left.insert(newData) }
        else                   { right = right.insert(newData) }
        updateBalance()
        return level()
    }
    
    private func level() -> AVLBinaryTreeElement<T> {
        if left.balance - right.balance > 1 {
            //print("rotate right")
            let tmp = left
            self.left = left.right
            tmp.right = self
            return tmp
        }
        else if left.balance - right.balance < -1 {
            //print("rotate left")
            let tmp = right
            self.right = right.left
            tmp.left = self
            return tmp
        }
        return self
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
    
    func updateBalance() {
        balance = max(left.balance, right.balance) + 1
    }
    
    override func array() -> [T] {
        var res = left.array()
        res.append(data!)
        return res + right.array()
    }
}

private class AVLBinaryTreeLeaf<T: Comparable> : AVLBinaryTreeElement<T> {}

























