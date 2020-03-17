//
//  BézierShape.swift
//  
//
//  Created by Ben Leggiero on 2020-02-15.
//

import Foundation
import NonEmpty



public typealias BezierShape = BézierShape



/// A shape made up of one or more Bézier paths
public struct BézierShape: Equatable {
    /// All the paths in this shape
    public var paths: NonEmptyArray<BézierPath>
}



public extension BézierShape {
    /// A shape that only has one path, and that path is devoid of points
    static let empty = BézierShape(paths: .init(.empty, []))
}
