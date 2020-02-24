//
//  BézierShapeConvertible.swift
//  
//
//  Created by Ben Leggiero on 2020-02-21.
//

import Foundation



public protocol BézierShapeConvertible {
    func bézierShape() -> BézierShape
}



public typealias BezierShapeConvertible = BézierShapeConvertible



public extension BezierShapeConvertible {
    func bezierShape() -> BezierShape {
        return bézierShape()
    }
}
