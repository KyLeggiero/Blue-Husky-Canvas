//
//  BézierShapeConvertible.swift
//  Blue Husky Canvas
//
//  Created by Ben Leggiero on 2020-02-21.
//  Copyright © 2020 Ben Leggiero BH-1-PS
//

import Foundation



/// Something which can be converted into a BézierShape
public protocol BézierShapeConvertible {
    /// The `BézierShape` version of this
    /// - Parameter location: The proposed position of the resulting shape, for context when building the Bézier shape
    func bézierShape(at location: CanvasPoint) -> BézierShape
}



public typealias BezierShapeConvertible = BézierShapeConvertible



public extension BezierShapeConvertible {
    /// The `BézierShape` version of this
    /// - Parameter location: The proposed position of the resulting shape, for context when building the Bézier shape
    @inline(__always)
    func bezierShape(at location: CanvasPoint) -> BezierShape {
        return bézierShape(at: location)
    }
}
