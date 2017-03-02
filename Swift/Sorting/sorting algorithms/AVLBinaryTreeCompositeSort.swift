//
//  AVLBinaryTreeCompositeSort.swift
//  Sort
//
//  Created by Paul Kraft on 21.12.15.
//  Copyright © 2015 kraft. All rights reserved.
//

import Cocoa

extension Array where Element : Comparable {
    mutating func avlBinaryTreeCompositeSort(by order: (Element, Element) throws -> Bool = { $0 < $1 }) rethrows {
        
    }
}

/*
private struct AVLBinaryTreeComposite < Element : Comparable > : BinTree {
}

private protocol AVLBinaryTreeCompositeNode : BinTreeNode {
    
}
 */

//just to illustrate how an average-level-tree looks like, when used for sorting
//for sorting, it's less efficient than BinaryTreeCompositeSort, because a rotation takes a long time compared to a a-little-longer path.
//this avl-tree uses the composite pattern, too, so left != nil is not necessary

/*
func avlBinaryTreeCompositeSort<T: Comparable>(unsorted: [T]) -> (name: String, array: [T]) {
    return ("AVLBinaryTreeCompositeSort", avlBinaryTreeCompositeSortRecursive(unsorted))
}

private func avlBinaryTreeCompositeSortRecursive<T: Comparable>(unsorted: [T]) -> [T] {
    return AVLBinaryTreeComposite<T>(unsorted).array()
}

private class AVLBinaryTreeComposite<T: Comparable> {
    private var root: AVLBinaryTreeCompositeElement<T>
    
    convenience init(_ array: [T]) {
        self.init(AVLBinaryTreeCompositeLeaf<T>())
        for i in array {
            root = root.insert(i)
        }
        //print("\n\tavl composite\n", dot())
    }
    
    init(_ root: AVLBinaryTreeCompositeElement<T>) {
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

private class AVLBinaryTreeCompositeElement<T:Comparable> {
    private var  left: AVLBinaryTreeCompositeElement<T> { get { return self } set { } }
    private var right: AVLBinaryTreeCompositeElement<T> { get { return self } set { } }
    private var data : T? { return nil }
    private var balance: Int { get { return -1 } set { } }

    func insert(newData: T) -> AVLBinaryTreeCompositeElement<T> {
        return AVLBinaryTreeCompositeNode<T>(newData)
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
}

private class AVLBinaryTreeCompositeNode<T: Comparable> : AVLBinaryTreeCompositeElement<T> {
    override private var  left: AVLBinaryTreeCompositeElement<T> { get { return  leftElement } set {  leftElement = newValue } }
    override private var right: AVLBinaryTreeCompositeElement<T> { get { return rightElement } set { rightElement = newValue } }
    override private var data : T? { return dataObject }
    override private var balance: Int { get { return bal } set { bal = newValue } }

    
    private var  leftElement: AVLBinaryTreeCompositeElement<T>
    private var rightElement: AVLBinaryTreeCompositeElement<T>
    private let dataObject: T
    private var bal: Int
    
    convenience init(_ newData: T) {
        self.init(newData, left: AVLBinaryTreeCompositeLeaf<T>(), right: AVLBinaryTreeCompositeLeaf<T>())
    }
    
    init(_ newData: T, left: AVLBinaryTreeCompositeElement<T>, right: AVLBinaryTreeCompositeElement<T>) {
        self.dataObject = newData
        self.leftElement = left
        self.rightElement = right
        self.bal = max(left.balance, right.balance) + 1
    }
    
    override func insert(newData: T) -> AVLBinaryTreeCompositeElement<T> {
        if newData < self.data { left  =  left.insert(newData) }
        else                   { right = right.insert(newData) }
        return level()
    }
    
    private func level() -> AVLBinaryTreeCompositeElement<T> {
        updateBalance()
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

private class AVLBinaryTreeCompositeLeaf<T: Comparable> : AVLBinaryTreeCompositeElement<T> {}
 
 */
