//
//  AVLBinaryTreeSort.swift
//  Sort
//
//  Created by Paul Kraft on 21.12.15.
//  Copyright © 2015 kraft. All rights reserved.
//

import Cocoa

extension Array where Element : Comparable {
    mutating func avlBinaryTreeSort(by order: (Element, Element) throws -> Bool = { $0 < $1 }) rethrows {
        // ...
        self = try AVLBinaryTree(self, order: order).array
    }
}

// TODO! currently not an AVL-Tree!

private struct AVLBinaryTree<E> : BinTree {
    typealias Element = E
    typealias Node = AVLBinaryTreeNode<E>
    init(_ elements: [E], order: (E, E) throws -> Bool) rethrows {
        guard elements.count > 1 else { self.order = order; return }
        self.order = order
        root = Node(elements.first!, order: order)
        for e in elements {
            try root!.insert(e, order: order)
        }
    }
    
    var root: AVLBinaryTreeNode<E>? = nil
    var order : (E, E) throws -> Bool
}

private final class AVLBinaryTreeNode < E > : BinTreeNode {
    typealias Element = E
    init(_ data: E, order: (E, E) throws -> Bool) {
        self.data = data
        self.order = order
    }
    
    func insert(_ data: Element, order: (Element, Element) throws -> Bool) rethrows {
        // ...
        if try order(data, self.data) {
            if  left == nil { left = AVLBinaryTreeNode(data, order: order) }
            else            { try left!.insert(data, order: order) }
        } else {
            if right == nil { right = AVLBinaryTreeNode(data, order: order) }
            else            { try right!.insert(data, order: order) }
        }
    }
    
    private var data    : E
    private var left    : AVLBinaryTreeNode<E>? = nil
    private var right   : AVLBinaryTreeNode<E>? = nil
    private let order   : (E, E) throws -> Bool
}



/*
private struct AVLBinaryTree<T: Comparable> {
    private var root: AVLBinaryTreeElement<T>?
    
    init(_ array: [T]) {
        self.init(nil)
        for i in array { insert(i) }
        //print("\n\tavl\n", dot())
    }
    
    init(_ root: AVLBinaryTreeElement<T>?) {
        self.root = root
    }
    
    mutating func insert(_ newData: T) {
        if root != nil { root = root!.insert(newData) }
        else           { root = AVLBinaryTreeElement(newData) }
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
    
    func size() -> Int {
        if root == nil { return 0 }
        return root!.size()
    }
}

private class AVLBinaryTreeElement<T: Comparable> {
    private let data: T
    private var  left: AVLBinaryTreeElement<T>?
    private var right: AVLBinaryTreeElement<T>?
    var balance: Int = -1
    
    convenience init(_ newData: T) {
        self.init(newData, left: nil, right: nil)
    }
    
    init(_ newData: T, left: AVLBinaryTreeElement<T>?, right: AVLBinaryTreeElement<T>?) {
        self.data = newData
        self.left = left
        self.right = right
    }
    
    func insert(_ newData: T) -> AVLBinaryTreeElement {
        if newData < self.data {
            if  left == nil { left = AVLBinaryTreeElement<T>(newData) }
            else            { left = left!.insert(newData) }
        }
        else {
            if right == nil { right = AVLBinaryTreeElement<T>(newData) }
            else            { right = right!.insert(newData) }
        }
        return level()
    }
    
    private func updateBalance() -> (left: Int, right: Int) {
        var lb: Int = -1, rb: Int = -1
        if  left != nil { lb = left!.balance }
        if right != nil { rb = right!.balance }
        self.balance = max(lb, rb) + 1
        return (lb, rb)
    }
    
    private func level() -> AVLBinaryTreeElement {
        let balances = updateBalance()
        if balances.left - balances.right > 1 {
            //print("rotate right")
            let tmp = left
            self.left = left!.right
            tmp!.right = self
            return tmp!
        }
        else if balances.left - balances.right < -1 {
            //print("rotate left")
            let tmp = right
            self.right = right!.left
            tmp!.left = self
            return tmp!
        }
        return self
    }
    
    func array() -> [T] {
        var res: [T] = []
        if left  != nil { res = res + left!.array() }
        res.append(data)
        if right != nil { res = res + right!.array() }
        return res
    }
    
    func size() -> Int {
        var erg = 1
        if  left != nil { erg +=  left!.size() }
        if right != nil { erg += right!.size() }
        return erg
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
 */
