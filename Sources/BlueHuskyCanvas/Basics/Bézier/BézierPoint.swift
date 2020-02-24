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
    ///
    /// For instance, setting this to `(-2, 1)` will lock it to always be two units lower on the X axis and 1 unit
    /// higher on the Y axis than `anchor`.
    public var precedingControlPointOffset: CanvasPoint? = nil
    
    /// The point at which this Bézier point rests, and to which preceding and succeeding Bézier points connect.
    public var anchor: CanvasPoint
    
    /// The Bézier control point after this one on the path. `nil` and `.zero` behave equivalently.
    ///
    /// For instance, setting this to `(2, -1)` will lock it to always be two units higher on the X axis and 1 unit
    /// lower on the Y axis than `anchor`.
    public var succedingControlPointOffset: CanvasPoint? = nil
    
    
    public init(
        precedingControlPointOffset: CanvasPoint? = nil,
        anchor: CanvasPoint,
        succedingControlPointOffset: CanvasPoint? = nil
    ) {
        self.precedingControlPointOffset = precedingControlPointOffset
        self.anchor = anchor
        self.succedingControlPointOffset = succedingControlPointOffset
    }
    
    
    /// Creates a Bézier point with no control points, just the given anchor
    /// - Parameter anchor: The anchor of the new Bézier point
    public init(_ anchor: CanvasPoint) {
        self.init(anchor: anchor)
    }
}
