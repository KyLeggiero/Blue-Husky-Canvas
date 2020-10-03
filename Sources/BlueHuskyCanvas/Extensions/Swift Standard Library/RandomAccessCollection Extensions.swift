//
//  RandomAccessCollection Extensions.swift
//  Blue Husky Canvas
//
//  Created by Ben Leggiero on 2020-02-23.
//  Copyright © 2020 Ben Leggiero BH-1-PS
//

import Foundation



public extension RandomAccessCollection
    where
        Self: MutableCollection,
        Index: Strideable
{
    mutating func mutateLast(with mutator: (inout Element) -> Void) {
        if isEmpty {
            return
        }
        else if count == 1 {
            return mutator(&self[startIndex])
        }
        else {
            return mutator(&self[endIndex.advanced(by: -1)])
        }
    }
}
