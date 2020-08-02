//
//  Circle + BézierShapeConvertible.swift
//  
//
//  Created by Ben Leggiero on 2020-02-23.
//

import Foundation
import NonEmpty



extension Circle: BézierShapeConvertible {
    public func bézierShape(at position: CanvasPoint) -> BézierShape {
        
        let frame = self.frame(at: position)
        let bézierCircularArcControlPointOffset = radius * .bézierCircularArcMultiplier
        
        return BézierShape
            .startBuilding()
            .move(to: frame.midXmaxY)
            
            // Someday, maybe this instaed:
//            .addArc(center: center, radius: radius, startAngle: .degrees(0), endAngle: .degrees(360))
            
            
            // Top-right arc ╮
            .addBézierCurve(to: frame.maxXmidY,
                            controlOffset1: CanvasPoint(x:  bézierCircularArcControlPointOffset,
                                                        y: 0),
                            controlOffset2: CanvasPoint(x: 0,
                                                        y:  bézierCircularArcControlPointOffset)
            )
            
            // Bottom-right arc ╯
            .addBézierCurve(to: frame.midXminY,
                            controlOffset1: CanvasPoint(x: 0,
                                                        y: -bézierCircularArcControlPointOffset),
                            controlOffset2: CanvasPoint(x:  bézierCircularArcControlPointOffset,
                                                        y: 0)
            )
            // Bottom-left arc ╰
            .addBézierCurve(to: frame.minXmidY,
                            controlOffset1: CanvasPoint(x: -bézierCircularArcControlPointOffset,
                                                        y: 0),
                            controlOffset2: CanvasPoint(x: 0,
                                                        y: -bézierCircularArcControlPointOffset)
            )
            // Top-left arc ╭
            .addBézierCurve(to: frame.midXmaxY,
                            controlOffset1: CanvasPoint(x: 0,
                                                        y:  bézierCircularArcControlPointOffset),
                            controlOffset2: CanvasPoint(x: -bézierCircularArcControlPointOffset,
                                                        y: 0)
            )
            .close()
            .doneBuilding()
    }
    
    
    func frame(at position: CanvasPoint) -> CanvasRect {
//        let diameter = self.diameter
//        let center = proposedFrame.center
//
//        return CanvasRect(
//            x: center.x - radius,
//            y: center.y - radius,
//            width: diameter,
//            height: diameter)
        
        let diameter = self.diameter
        
        return CanvasRect(
            x: position.x - radius,
            y: position.y - radius,
            width: diameter,
            height: diameter)
    }
    
    
    var diameter: CGFloat { radius * 2 }
}
