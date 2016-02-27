//
//  AVLBinaryTreeSort.swift
//  Sort
//
//  Created by Paul Kraft on 21.12.15.
//  Copyright © 2015 kraft. All rights reserved.
//

import Cocoa

func avlBinaryTreeSort<T: Comparable>(unsorted: [T]) -> (name: String, array: [T]) {
    return ("AVLBinaryTreeSort", avlBinaryTreeSortRecursive(unsorted))
}

private func avlBinaryTreeSortRecursive<T: Comparable>(unsorted: [T]) -> [T] {
    return AVLBinaryTree<T>(unsorted).array()
}

private class AVLBinaryTree<T: Comparable> {
    private var root: AVLBinaryTreeElement<T>?
    
    convenience init(_ array: [T]) {
        self.init(nil)
        for i in array {
            insert(i)
        }
        //print("\n\tavl\n", dot())
    }
    
    init(_ root: AVLBinaryTreeElement<T>?) {
        self.root = root
    }
    
    func insert(newData: T) {
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
    
    func insert(newData: T) -> AVLBinaryTreeElement {
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