//
//  SortableCollection.swift
//  Sorting
//
//  Created by Paul Kraft on 07.08.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

public protocol SortableCollection : Collection {
    associatedtype Element = Iterator.Element
    var indices : CountableRange<Int> { get }
    subscript(_: Int) -> Element { get set }
}

public protocol InsertingCollection : Collection {
    associatedtype Element = Iterator.Element
    mutating func insert(_: Element, at: Int)
    mutating func remove(at: Int) -> Element

}

public protocol SortableInsertingCollection : SortableCollection, InsertingCollection {}

extension Array             : SortableInsertingCollection {}
extension ArraySlice        : SortableInsertingCollection {}
extension CollectionOfOne   : SortableCollection {}
extension ContiguousArray   : SortableInsertingCollection {}
extension EmptyCollection   : SortableCollection {}





