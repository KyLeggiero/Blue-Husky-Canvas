//
//  BézierShapeConvertible.swift
//  
//
//  Created by Ben Leggiero on 2020-02-21.
//

import Foundation



/// Something which can be converted into a BézierShape
public protocol BézierShapeConvertible {
    /// The `BézierShape` version of this
    func bézierShape() -> BézierShape
}



public typealias BezierShapeConvertible = BézierShapeConvertible



public extension BezierShapeConvertible {
    /// The `BézierShape` version of this
    func bezierShape() -> BezierShape {
        return bézierShape()
    }
}
