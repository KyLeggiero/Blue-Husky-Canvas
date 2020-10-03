//
//  BézierPath.swift
//  Blue Husky Canvas
//
//  Created by Ben Leggiero on 2020-02-15.
//  Copyright © 2020 Ben Leggiero BH-1-PS
//

import Foundation

import CollectionTools
import RectangleTools



/// A Bézier path: a path made up of connected (or disconnected) Bézier points
public typealias BezierPath = BézierPath



/// A Bézier path: a path made up of connected (or disconnected) Bézier points
public struct BézierPath: Equatable {
    
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
public struct BézierPathPoint: Equatable {
    
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
    
    
    var segments: [BézierPathSegment] { 
        return points
            .sequentialPairs
            .compactMap { first, second in
                second.shouldConnectToPreviousPoint
                    ? BézierPathSegment(firstPoint: first.point,
                                         secondPoint: second.point)
                    : nil
        }
    }
}



// MARK: - Frame Calculation

public extension BézierPath {
    
    func calculateFrame() -> CanvasRect {
        segments
            .lazy
            .map { $0.calculateFrame() }
            .grandUnion()
            ?? .one
    }
    
    //function getBoundsOfPath (path)
    //{
    //    //var curve = path2curve(path);
    //    curve = path;
    //    ////console.log(JSON.stringify(path));
    //    ////console.log("--------------------------------------------------------------------");
    //    //console.log(JSON.stringify(curve));
    //    var bounds, s, startX, startY,
    //        minx = Number.MAX_VALUE,
    //        miny = Number.MAX_VALUE,
    //        maxx = Number.MIN_VALUE,
    //        maxy = Number.MIN_VALUE;
    //    var isC = false;
    //    for (var i = 0, ilen = curve.length; i < ilen; i++)
    //    {
    //        //var val = 6;
    //        //if(i!=val && i!=val-1) continue;
    //        var s = curve[i];
    //        ////console.log(s);
    //
    //        if (s[0] == 'M')
    //        {
    //            if (typeof(curve[i+1]) != "undefined" && curve[i+1][0] == "C")
    //            {
    //                startX = s[1];
    //                startY = s[2];
    //                if (startX < minx) minx = startX;
    //                if (startX > maxx) maxx = startX;
    //                if (startY < miny) miny = startY;
    //                if (startY > maxy) maxy = startY;
    //            }
    //        }
    //        else
    //
    //        if (s[0] == 'C')
    //        {
    //            isC = true;
    //            //if(i==val)
    //            //{
    //            bounds = getBoundsOfCurve(startX, startY, s[1], s[2], s[3], s[4], s[5], s[6]);
    //            //bounds = calculate_standard_bbox(startX, startY, s[1], s[2], s[3], s[4], s[5], s[6]);
    //            //bounds = cubic_extrema_external(startX, startY, s[1], s[2], s[3], s[4], s[5], s[6]);
    //
    //            ////console.log(JSON.stringify(bounds));
    //            if (bounds.left < minx) minx = bounds.left;
    //            if (bounds.right > maxx) maxx = bounds.right;
    //            if (bounds.top < miny) miny = bounds.top;
    //            if (bounds.bottom > maxy) maxy = bounds.bottom;
    //            startX = s[5];
    //            startY = s[6];
    //        }
    //        ////console.log(JSON.stringify(bounds));
    //        //if(s[0] == 'C')
    //        //{
    //        //  currentX = s[5], currentY = s[6];
    //        //}
    //
    //    }
    //    //    left: this.left + (minX + deltaX / 2),
    //    //          top: this.top + (minY + deltaY / 2),
    //
    //    if (!isC) minx = maxx = miny = maxy = 0;
    //
    //    var boundsFinal = {
    //        left: minx,
    //        top: miny,
    //        width: maxx - minx,
    //        height: maxy - miny
    //    };
    //    ////console.log(JSON.stringify(boundsFinal));
    //    return boundsFinal;
    //}
    //window.getBoundsOfPath = getBoundsOfPath;
    //window.getBoundsOfCurve = getBoundsOfCurve;
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
