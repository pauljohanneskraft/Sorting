//
//  General.swift
//  Sorting
//
//  Created by Paul Kraft on 02.08.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

import Foundation

extension Array where Element : Comparable {
    var isSorted : Bool {
        for i in self.indices.dropLast() {
            if self[i + 1] < self[i] {
                print(self[i + 1], "at", i + 1)
                print("<")
                print(self[i], "at", i)
                return false
            }
        }
        return true
    }
}
