//
//  BézierPoint.swift
//  
//
//  Created by Ben Leggiero on 2020-02-15.
//

import Foundation



/// A point along a Bézier path
public typealias BezierPoint = BézierPoint



/// A point along a Bézier path
public struct BézierPoint {
    /// The Bézier control point before this one on the path. `nil` and `.zero` behave equivalently.
    public var precedingControlPointOffset: CanvasPoint? = nil
    
    /// The point at which this Bézier point rests, and to which preceding and succeeding Bézier points connect.
    public var anchor: CanvasPoint
    
    /// The Bézier control point after this one on the path. `nil` and `.zero` behave equivalently.
    public var succedingControlPointOffset: CanvasPoint? = nil
}
