//
//  BézierShapeDrawing.swift
//  
//
//  Created by Ben Leggiero on 2020-02-21.
//

import Foundation



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
///     .startDrawing()
///     .move(to: coordinates.minXminY)
///     .line(to: coordinates.maxXminY)
///     .line(to: coordinates.maxXmaxY)
///     .line(to: coordinates.minXmaxY)
///     .close()
///     .doneDrawing()
/// ```
public typealias BezierShapeDrawing = BézierShapeDrawing



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
///     .startDrawing()
///     .move(to: coordinates.minXminY)
///     .line(to: coordinates.maxXminY)
///     .line(to: coordinates.maxXmaxY)
///     .line(to: coordinates.minXmaxY)
///     .close()
///     .doneDrawing()
/// ```
public final class BézierShapeDrawing {
    
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

public extension BézierShapeDrawing {
    
    /// Moves the imaginary cursor to the given canvas point, without drawing a line.
    ///
    /// This is useful for continuing the current path after a gap. If you want to start a new shape, call `close()` or
    /// `finishPath(leaveOpen:)` before this.
    ///
    /// - Parameter point: The new location of the imaginary cursor
    /// - Returns: This drawing object, so you can chain drawing calls
    func move(to point: CanvasPoint) -> Self {
        if didJustFinishPath {
            shapeSoFar.paths.append(.empty)
            didJustFinishPath = false
        }
        else {
            shapeSoFar.paths.mutateLast { $0.move(to: point) }
        }
        
        return self
    }
    
    
    /// Moves the imaginary cursor to the given canvas point, without drawing a line.
    ///
    /// - Parameter point: The new location of the imaginary cursor
    /// - Returns: This drawing object, so you can chain drawing calls
    func line(to point: CanvasPoint) -> Self {
        if didJustFinishPath {
            shapeSoFar.paths.append(.empty)
            didJustFinishPath = false
        }
        else {
            shapeSoFar.paths.mutateLast { $0.line(to: point) }
        }
        
        return self
    }
    
    
    func addArc(center: CanvasPoint,
                radius: CanvasLength,
                startAngle: Angle,
                endAngle: Angle) -> Self {
        <#function body#>
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
    func doneDrawing() -> BézierShape {
        return shapeSoFar
    }
}



// MARK: - Ergonomics

public extension BézierShape {
    /// Returns a drawing object, starting with this shape
    func forDrawing() -> BézierShapeDrawing {
        return BézierShapeDrawing(shape: self)
    }
    
    
    /// Returns a new drawing object, starting with an empty shape
    static func startDrawing() -> BézierShapeDrawing {
        return BézierShape.empty.forDrawing()
    }
}
