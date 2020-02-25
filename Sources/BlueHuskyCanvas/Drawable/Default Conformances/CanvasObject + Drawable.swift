//
//  CanvasObject + Drawable.swift
//  
//
//  Created by Ben Leggiero on 2020-02-24.
//

import Foundation
import CrossKitTypes



public extension CanvasObject {
    func draw(in context: CGContext, targetSize: CGSize, environment: Self.Environment) {
        let nativePath = NativeBezierPath()
        
        switch self.style.fill?.approach {
        case .always:
            nativePath.windingRule = .nonZero
            
        case .evenOdd:
            nativePath.windingRule = .evenOdd
            
        case .none:
            break
        }
        
        self.bézierShape.paths.forEach { path in
            guard let first = path.points.first else { return }
            
            nativePath.move(to: first.point.anchor)
            
            let allButFirst = path.points.dropFirst()
            
            
            allButFirst.indices.forEach { pointIndex in
                let thisPoint = path.points[pointIndex].point
                let shouldConnect = path.points[pointIndex].shouldConnectToPreviousPoint
                let previousPoint = path.points[pointIndex - 1].point
                
                if shouldConnect {
                    if nil == thisPoint.precedingControlPointOffset,
                        nil == previousPoint.succedingControlPointOffset {
                        nativePath.line(to: thisPoint.anchor)
                    }
                    else {
                        
                        let controlPoint1 = resolve(offsetPoint: previousPoint.succedingControlPointOffset,
                                                    near: previousPoint.anchor)
                        let controlPoint2 = resolve(offsetPoint: thisPoint.precedingControlPointOffset,
                                                    near: thisPoint.anchor)
                        
                        nativePath.curve(to: thisPoint.anchor,
                                         controlPoint1: controlPoint1,
                                         controlPoint2: controlPoint2)
                    }
                }
                else {
                    nativePath.move(to: thisPoint.anchor)
                }
            }
            
            
            if allButFirst.last?.shouldConnectToPreviousPoint ?? false {
                nativePath.close()
            }
        }
        
        
        if let fill = style.fill {
            switch fill.content {
            case .solid(let color):
                color.setFill()
                nativePath.fill()
            }
        }
        
        if let stroke = style.stroke {
            switch stroke.content {
            case .solid(let color):
                color.setStroke()
                context.setLineWidth(stroke.thickness)
                nativePath.stroke()
            }
        }
    }
}



private func resolve(offsetPoint: CanvasPoint?, near anchor: CanvasPoint) -> CGPoint {
    if let offsetPoint = offsetPoint {
        return anchor + offsetPoint
    }
    else {
        return anchor
    }
}
