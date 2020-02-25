//
//  BézierPath.swift
//  
//
//  Created by Ben Leggiero on 2020-02-15.
//

import Foundation



/// A Bézier path: a path made up of connected (or disconnected) Bézier points
public typealias BezierPath = BézierPath



/// A Bézier path: a path made up of connected (or disconnected) Bézier points
public struct BézierPath {
    
    /// All the points in this path.
    ///
    /// If the first one's `shouldConnectToPreviousPoint` is `true`, it's treated as if it connects around to the last
    /// point. That behavior, of course, is nonsense to pay attention to if this path is empty or only has 1 point.
    public var points: [BézierPathPoint]
    
    
    public init(points: [BézierPathPoint]) {
        self.points = points
    }
}



/// A point in a Bézier path
public struct BézierPathPoint {
    
    /// The point, itself
    public var point: BézierPoint
    
    /// Whether this point should connect to the previous point in the path
    public var shouldConnectToPreviousPoint: Bool = true
}



// MARK: - Premades

public extension BézierPath {
    /// A path without any points
    static let empty = BézierPath(points: [])
}



// MARK: - Basic functionality

public extension BézierPath {
    
    /// Indicates whether this path is devoid of points
    var isEmpty: Bool {
        self.points.isEmpty
    }
    
    
    /// Creates a path of connected Bézier points, only connecting the first and last if `isClosed` is `true`
    ///
    /// - Parameters:
    ///   - points:   All the points in the new path
    ///   - isClosed: _optional_ - Whether to connect the last point to the first one. Defaults to `true`.
    init(points: [BézierPoint], isClosed: Bool = true) {
        self.points = points.map { BézierPathPoint(point: $0, shouldConnectToPreviousPoint: true) }
        
        if !isClosed {
            self.points[self.points.endIndex - 1].shouldConnectToPreviousPoint = false
        }
    }
    
    
    /// Determines whether this path is closed (every point connects to the next and the first point connects around to
    /// the last point).
    ///
    /// - Note: If this path is empty or only has one point, this returns `false`. Not that that means anything.
    func isClosed() -> Bool {
        guard
            points.count > 1,
            let first = points.first
            else
        {
            // if it's empty or only has 1 point, consider it open
            return false
        }
        
        if !first.shouldConnectToPreviousPoint {
            // The most common usage is likely to be through the `init(points:isClosed:)` initializer, so this
            // optimizes for that by checking the connection of the first to the last before iterating over the rest
            return false
        }
        else {
            // If it is not empty, and the first connects to the last, check all the rest. I don't expect this to
            // commonly return `false`, but since it can't yet be guaranteed, it has to be checked.
            return !points.contains { !$0.shouldConnectToPreviousPoint }
        }
    }
}



// MARK: - Mutation

public extension BézierPath {
    
    /// Appends a new Bézier point to the end of this path, not connecting it to the preceding point
    ///
    /// - Parameter point: The anchor of the new Bézier point
    mutating func move(to point: CanvasPoint) {
        self.append(point: point, shouldConnectToPreviousPoint: false)
    }
    
    
    /// Appends a new Bézier point to the end of this path, connecting it to the preceding point
    ///
    /// - Parameter point: The anchor of the new Bézier point
    mutating func line(to point: CanvasPoint) {
        self.append(point: point, shouldConnectToPreviousPoint: true)
    }
    
    
    // TODO:
//    /// Sweeps the imaginary cursor along a circular arc about the given radius, drawing that arc from the given start
//    /// angle to the given end angle
//    ///
//    /// - Parameters:
//    ///   - center:     The point at the center of the arc
//    ///   - radius:     The radius of the arc; the distance at which each point in the arc lies
//    ///   - startAngle: The angle along a circle at which the arc starts
//    ///   - endAngle:   The angle along a circle at which the arc ends
//    ///   - clockwise:  _optional_ - Whether to draw the arc in a clockwise direction. Defaults to `true`.
//    ///
//    /// - Returns: This drawing object, so you can chain drawing calls
//    mutating func addArc(center: CanvasPoint,
//                         radius: CanvasLength,
//                         startAngle: Angle,
//                         endAngle: Angle,
//                         clockwise: Bool = true)
//    {
//        let newPoint = BézierPoint(
//            precedingControlPointOffset: ???,
//            anchor: point)
//        self.points.mutateLast { $0.point.succedingControlPointOffset = ??? }
//
//        self.points.append(BézierPathPoint(point: newPoint, shouldConnectToPreviousPoint: true))
//    }
    
    
    /// Adds a Bézier curve to the path
    ///
    /// ```plain
    /// Previous Point's
    ///           anchor
    ///           (2, 2)               controlOffset1
    ///                 X--.           (16, 3)
    ///                     `-        x
    ///                       \
    ///                        \
    ///                         \
    ///                         |
    ///                         |
    ///                          |
    ///                          |
    ///                           |
    ///                           |        newAnchor
    ///                           '        (20, 14)
    ///                            \     .X
    ///                             `-.-'
    ///
    ///
    ///        controlOffset2
    ///               (7, 20)
    ///                      x
    /// ```
    ///
    /// - Parameters:
    ///   - newAnchor:      The anchor point of the new Bézier point
    ///   - controlOffset1: The control point succeeding the previous point's anchor
    ///   - controlOffset2: The control point preceding the new point's anchor
    mutating func addBézierCurve(
        to newAnchor: CanvasPoint,
        controlOffset1: CanvasPoint,
        controlOffset2: CanvasPoint)
    {
        self.points.mutateLast { $0.point.succedingControlPointOffset = controlOffset1 }
        self.points.append(BézierPathPoint(point: BézierPoint(precedingControlPointOffset: controlOffset2,
                                                              anchor: newAnchor),
                                           shouldConnectToPreviousPoint: true))
    }
    
    
    /// Appends a new Bézier point to the end of this path, optionally connecting it to the preceding point
    ///
    /// - Parameters:
    ///   - point:                        The anchor of the new Bézier point
    ///   - shouldConnectToPreviousPoint: Whether to connect the new point to the one just before it
    private mutating func append(point: CanvasPoint, shouldConnectToPreviousPoint: Bool) {
        self.points.append(BézierPathPoint(point: BézierPoint(anchor: point),
                                           shouldConnectToPreviousPoint: shouldConnectToPreviousPoint))
    }
    
    
    /// Ensures the first point is connected around to the last point
    ///
    /// - Attention: This doesn't affect any point other than the first. To ensure all points are connected and the
    ///              path is closed, use `closeAllPoints()`.
    mutating func close() {
        guard !isEmpty else { return }
        self.points[points.startIndex].shouldConnectToPreviousPoint = true
    }
    
    
    /// Ensures all points are connected and no segments are open
    ///
    /// - Attention: This is is complexity `O(n)`. If all you want to do is make sure that the first point connects
    ///              back around to the last, use `close()`.
    mutating func closeAllPoints() {
        self.points.indices.forEach { index in
            self.points[index].shouldConnectToPreviousPoint = true
        }
    }
}
