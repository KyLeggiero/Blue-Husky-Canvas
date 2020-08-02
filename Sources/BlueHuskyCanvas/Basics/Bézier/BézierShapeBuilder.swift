//
//  BézierShapeBuilder.swift
//  
//
//  Created by Ben Leggiero on 2020-02-21.
//

import Foundation
import FunctionTools



/// A convenient way to draw a Bézier shape in code using an imaginary cursor.
///
/// This is the style of API you might be used to if you've done manual 2D graphics drawing before, featuring:
/// - `move(to:)`
/// - `line(to:)`
/// - `close()`
///
/// For instance, to draw a rectangle, you might do this:
/// ```swift
/// BézierShape
///     .startBuilding()
///     .move(to: coordinates.minXminY)
///     .line(to: coordinates.maxXminY)
///     .line(to: coordinates.maxXmaxY)
///     .line(to: coordinates.minXmaxY)
///     .close()
///     .doneBuilding()
/// ```
public typealias BezierShapeBuilder = BézierShapeBuilder



/// A convenient way to draw a Bézier shape in code using an imaginary cursor.
///
/// This is the style of API you might be used to if you've done manual 2D graphics drawing before, featuring:
/// - `move(to:)`
/// - `line(to:)`
/// - `close()`
///
/// For instance, to draw a rectangle, you might do this:
/// ```swift
/// BézierShape
///     .startBuilding()
///     .move(to: coordinates.minXminY)
///     .line(to: coordinates.maxXminY)
///     .line(to: coordinates.maxXmaxY)
///     .line(to: coordinates.minXmaxY)
///     .close()
///     .doneBuilding()
/// ```
public final class BézierShapeBuilder {
    
    /// The current Bézier shape
    fileprivate var shapeSoFar: BézierShape
    
    /// Whether the API user just finished a path.
    ///
    /// This allows the API to be cleaner:
    /// - If they call `close()` and then `doneDrawing()`, then the resulting shape has only the paths they drew
    /// - If they call `close()` and then `move(to:)` or `line(to:)`, then we use this to know to append a new empty
    ///   shape before performing that operation
    fileprivate var didJustFinishPath = false
    
    fileprivate init(shape: BézierShape) {
        self.shapeSoFar = shape
    }
}



// MARK: - Public API

public extension BézierShapeBuilder {
    
    /// Moves the imaginary cursor to the given canvas point, without drawing a line.
    ///
    /// This is useful for continuing the current path after a gap. If you want to start a new shape, call `close()` or
    /// `finishPath(leaveOpen:)` before this.
    ///
    /// - Parameter point: The new location of the imaginary cursor
    /// - Returns: This drawing object, so you can chain drawing calls
    func move(to point: CanvasPoint) -> Self {
        mutateLastPath { $0.move(to: point) }
    }
    
    
    /// Moves the imaginary cursor to the given canvas point, without drawing a line.
    ///
    /// - Parameter point: The new location of the imaginary cursor
    /// - Returns: This drawing object, so you can chain drawing calls
    func line(to point: CanvasPoint) -> Self {
        mutateLastPath { $0.line(to: point) }
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
//    func addArc(center: CanvasPoint,
//                radius: CanvasLength,
//                startAngle: Angle,
//                endAngle: Angle,
//                clockwise: Bool = true) -> Self {
//        mutateLastPath {
//            $0.addArc(center: center,
//                      radius: radius,
//                      startAngle: startAngle,
//                      endAngle: endAngle,
//                      clockwise: clockwise)
//        }
//    }
    
    
    /// Adds a Bézier curve to the path, also moving the virtual cursor to `newAnchor`
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
    ///
    /// - Returns: This drawing object, so you can chain drawing calls
    func addBézierCurve(
        to newAnchor: CanvasPoint,
        controlOffset1: CanvasPoint,
        controlOffset2: CanvasPoint
    ) -> Self
    {
        mutateLastPath {
            $0.addBézierCurve(
                to: newAnchor,
                controlOffset1: controlOffset1,
                controlOffset2: controlOffset2
            )
        }
    }
    
    
    private func mutateLastPath(with mutator: (inout BézierPath) -> Void) -> Self {
        if didJustFinishPath {
            shapeSoFar.paths.append(.empty)
            didJustFinishPath = false
        }
        else {
            shapeSoFar.paths.mutateLast(with: mutator)
        }
        
        return self
    }
    
    
    /// Closes the current path, so that any further drawing which might happen will be on a new path.
    ///
    /// - Returns: This drawing object, so you can chain drawing calls
    func close() -> Self {
        shapeSoFar.paths.mutateLast { $0.close() }
        didJustFinishPath = true
        return self
    }
    
    
    /// Finishes the current path, optionally leaving it open, so that any further drawing which might happen will be
    /// on a new path.
    ///
    /// - Returns: This drawing object, so you can chain drawing calls
    func finishPath(leaveOpen: Bool) -> Self {
        if leaveOpen {
            didJustFinishPath = true
            return self
        }
        else {
            return close()
        }
    }
    
    
    /// Returns the shape that you've drawn, without making any more changes.
    ///
    /// If you want to use this object later to continue drawing, it will resume drawing as if you had not called this.
    func doneBuilding() -> BézierShape {
        return shapeSoFar
    }
}



// MARK: - Ergonomics

public extension BézierShape {
    /// Returns a drawing object, starting with this shape
    func continueBuilding() -> BézierShapeBuilder {
        return BézierShapeBuilder(shape: self)
    }
    
    
    /// Returns a new drawing object, starting with an empty shape
    static func startBuilding() -> BézierShapeBuilder {
        return BézierShape.empty.continueBuilding()
    }
    
    
    static func build(in buildOperation: Transformer<BézierShapeBuilder, BézierShapeBuilder>) -> Self {
        buildOperation(Self.startBuilding()).doneBuilding()
    }
}
