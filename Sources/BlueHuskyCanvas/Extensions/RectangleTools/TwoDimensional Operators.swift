//
//  TwoDimensional Operators.swift
//  Blue Husky Canvas
//
//  Created by Ben Leggiero on 2020-02-24.
//  Copyright © 2020 Ben Leggiero BH-1-PS
//

import RectangleTools



public extension TwoDimensional where Length: AdditiveArithmetic {
    
    /// Returns the result of adding each x and each y. For instance, `(6, 2) + (1, 9) == (7, 11)`
    ///
    /// - Parameters:
    ///   - lhs: The base
    ///   - rhs: The x and y to respectively add to `lhs`'s
    static func + (lhs: Self, rhs: Self) -> Self {
        return Self.init(measurementX: lhs.measurementX + rhs.measurementX,
                         measurementY: lhs.measurementY + rhs.measurementY)
    }
}
