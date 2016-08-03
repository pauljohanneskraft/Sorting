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
    public mutating func binaryTreeSort(by order: (Element, Element) throws -> Bool) rethrows {
        self = try BinaryTree(self, order: order).array
    }
}

private struct BinaryTree<E> : BinTree {
    typealias Element = E
    typealias Node = BinaryTreeNode<E>
    init(_ elements: [E], order: (E, E) throws -> Bool) rethrows {
        guard elements.count > 1 else { self.order = order; return }
        self.order = order
        root = Node(elements.first!, order: order)
        for e in elements {
            try root!.insert(e, order: order)
        }
    }
    
    var root: BinaryTreeNode<E>? = nil
    var order : (E, E) throws -> Bool
}

private final class BinaryTreeNode < E > : BinTreeNode {
    typealias Element = E
    init(_ data: E, order: (E, E) throws -> Bool) {
        self.data = data
        self.order = order
    }
    private var data    : E
    private var left    : BinaryTreeNode<E>? = nil
    private var right   : BinaryTreeNode<E>? = nil
    private let order   : (E, E) throws -> Bool
}
