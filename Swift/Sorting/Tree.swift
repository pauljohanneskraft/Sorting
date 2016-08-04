//
//  Tree.swift
//  Sorting
//
//  Created by Paul Kraft on 01.08.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

import Foundation

protocol Tree {
    associatedtype Element
    associatedtype Node : TreeNode
    var dot : String { get }
}

extension Tree {}

protocol TreeNode {
    associatedtype Element
    var data    : Element   { get set }
    var dot     : String    { get }
    var array   : [Element] { get }
}

extension TreeNode {}

protocol BinTreeNode : TreeNode {
    associatedtype Element
    init(_: Element, order: (Element, Element) throws -> Bool)
    var left : Self? { get set }
    var right: Self? { get set }
    var order : (Element, Element) throws -> Bool { get }
}

extension BinTreeNode {
    var dot: String {
        var result = ""
        if  left != nil {
            result += "\t\t\(self.data) -> \( left!.data) [label=left] \n"
        }
        if right != nil {
            result += "\t\t\(self.data) -> \(right!.data) [label=right]\n"
        }
        if  left != nil { result +=  left!.dot }
        if right != nil { result += right!.dot }
        return result
    }
    
    mutating func insert(_ data: Element, order: (Element, Element) throws -> Bool) rethrows {
        if try order(data, self.data) {
            if  left == nil { left = Self(data, order: order) }
            else            { try left!.insert(data, order: order) }
        } else {
            if right == nil { right = Self(data, order: order) }
            else            { try right!.insert(data, order: order) }
        }
    }
    
    var array : [Element] {
        var result : [Element] = []
        if left  != nil { result +=  left!.array }
        result.append(self.data)
        if right != nil { result += right!.array }
        return result

    }
}

protocol BinTree : Tree {
    var root : Node? { get set }
}

extension BinTree where Node : BinTreeNode, Node.Element == Self.Element {
    mutating func insert(_ elem: Element, order: (Element, Element) throws -> Bool) rethrows {
        if root != nil { try root!.insert(elem, order: order) }
        else { root = Node(elem, order: order) }
    }
}

extension BinTree where Node.Element == Self.Element {
    var dot: String {
        var result = "\tdigraph g { \n\t\tgraph [ordering = out] \n"
        if root != nil { result += root!.dot }
        return result + "\t}\n"
    }
    var array : [Element] {
        if root == nil { return [] }
        return root!.array
    }
}

protocol BinTreeCompositeNode : TreeNode {
    init(_: Element, order: (Element, Element) throws -> Bool)
    mutating func insert(_ data: Element, order: (Element, Element) throws -> Bool) rethrows
}

// ...
extension BinTree where Node: BinTreeCompositeNode, Node.Element == Self.Element {
    mutating func insert(_ elem: Element, order: (Element, Element) throws -> Bool) rethrows {
        if root != nil { try root!.insert(elem, order: order) }
        else { root = Node(elem, order: order) }
    }
}









