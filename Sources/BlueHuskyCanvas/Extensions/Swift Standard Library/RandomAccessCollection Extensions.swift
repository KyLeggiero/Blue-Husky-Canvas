//
//  RandomAccessCollection Extensions.swift
//  
//
//  Created by Ben Leggiero on 2020-02-23.
//

import Foundation



public extension RandomAccessCollection
    where
        Self: MutableCollection,
        Index: Strideable
{
    mutating func mutateLast(with mutator: (inout Element) -> Void) {
        mutator(&self[endIndex.advanced(by: -1)])
    }
}
