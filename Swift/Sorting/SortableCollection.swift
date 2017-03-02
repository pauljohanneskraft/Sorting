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
    var array : [Element] { get }
    subscript(_: Int) -> Element { get set }
}

public protocol InsertingCollection : Collection {
    associatedtype Element = Iterator.Element
    init()
    init(_: [Element])
    subscript(_: CountableRange<Int>) -> ArraySlice<Element> { get }
    mutating func insert(_: Element, at: Int)
    mutating func remove(at: Int) -> Element

}

public protocol SortableInsertingCollection : SortableCollection, InsertingCollection {}

extension Array             : SortableInsertingCollection {
    public var array : [Element] { return self }
}
extension ArraySlice        : SortableInsertingCollection {
    public var array : [Element] { return Array(self) }
}
extension CollectionOfOne   : SortableCollection {
    public var array : [Element] { return Array(self) }
}
extension ContiguousArray   : SortableInsertingCollection {
    public var array : [Element] { return Array(self) }
}
extension EmptyCollection   : SortableCollection {
    public var array : [Element] { return Array(self) }
}





