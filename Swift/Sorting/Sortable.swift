//
//  Sortable.swift
//  Sorting
//
//  Created by Paul Kraft on 07.08.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

import Foundation

public protocol Sortable : Collection {
    associatedtype Element = Iterator.Element
    var indices : CountableRange<Int> { get }
    var first : Element? { get }
    var last : Element? { get }
    subscript(_: Int) -> Element { get set }
    mutating func insert(_: Element, at: Int)
    mutating func remove(at: Int) -> Element
}

extension Array : Sortable {}
extension ArraySlice : Sortable {}
