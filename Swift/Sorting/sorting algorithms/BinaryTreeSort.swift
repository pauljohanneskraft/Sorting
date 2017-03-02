//
//  BinaryTreeSort.swift
//  Sort
//
//  Created by Paul Kraft on 21.12.15.
//  Copyright © 2015 Paul Kraft. All rights reserved.
//

import Cocoa

extension Array where Element : Comparable {
    public mutating func binaryTreeSort() {
        self.binaryTreeSort(by: { $0 < $1 })
    }
}

extension Array {
    public mutating func binaryTreeSort(by order: @escaping (Element, Element) throws -> Bool) rethrows {
        // ..
        let e = try BinaryTree(self, order: order)
        // print(e.dot)
        self = e.array
    }
}


private struct BinaryTree<E> : BinTree {
    typealias Element = E
    typealias Node = BinaryTreeNode<E>
    init(_ elements: [E], order: @escaping (E, E) throws -> Bool) rethrows {
        guard elements.count > 1 else { self.order = order; return }
        self.order = order
        root = Node(elements[0], order: order)
        for e in elements.dropFirst() {
            try root!.insert(e, order: order)
        }
    }
    
    var root: BinaryTreeNode<E>? = nil
    var order : (E, E) throws -> Bool
}

private final class BinaryTreeNode < E > : BinTreeNode {
    typealias Element = E
    init(_ data: E, order: @escaping (E, E) throws -> Bool) {
        self.data = data
        self.order = order
    }
    fileprivate var data    : E
    fileprivate var left    : BinaryTreeNode<E>? = nil
    fileprivate var right   : BinaryTreeNode<E>? = nil
    fileprivate let order   : (E, E) throws -> Bool
}
