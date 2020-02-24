//
//  BézierShapeDrawing.swift
//  
//
//  Created by Ben Leggiero on 2020-02-21.
//

import Foundation



public typealias BezierShapeDrawing = BézierShapeDrawing



public final class BézierShapeDrawing {
    fileprivate var shapeSoFar: BézierShape
    fileprivate var didJustFinishPath = false
    
    fileprivate init(shape: BézierShape) {
        self.shapeSoFar = shape
    }
}



// MARK: - Public API

public extension BézierShapeDrawing {
    
    func move(to point: CanvasPoint) -> Self {
        if didJustFinishPath {
            shapeSoFar.paths.append(.empty)
            didJustFinishPath = false
        }
        else {
            shapeSoFar.paths[shapeSoFar.paths.endIndex - 1].move(to: point)
        }
        
        return self
    }
    
    
    func line(to point: CanvasPoint) -> Self {
        if didJustFinishPath {
            shapeSoFar.paths.append(.empty)
            didJustFinishPath = false
        }
        else {
            shapeSoFar.paths[shapeSoFar.paths.endIndex - 1].line(to: point)
        }
        
        return self
    }
    
    
    func close() -> Self {
        shapeSoFar.paths[shapeSoFar.paths.endIndex - 1].close()
        didJustFinishPath = true
        return self
    }
    
    
    func finishPath(leaveOpen: Bool) -> Self {
        if leaveOpen {
            didJustFinishPath = true
            return self
        }
        else {
            return close()
        }
    }
    
    
    func doneDrawing() -> BézierShape {
        return shapeSoFar
    }
}



// MARK: - Ergonomics

public extension BézierShape {
    func forDrawing() -> BézierShapeDrawing {
        return BézierShapeDrawing(shape: self)
    }
    
    
    static func startDrawing() -> BézierShapeDrawing {
        return BézierShape.empty.forDrawing()
    }
}
