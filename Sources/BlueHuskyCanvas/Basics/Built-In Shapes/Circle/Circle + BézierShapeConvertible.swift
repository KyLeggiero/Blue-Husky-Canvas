//
//  Circle + BézierShapeConvertible.swift
//  
//
//  Created by Ben Leggiero on 2020-02-23.
//

import Foundation
import NonEmpty



extension Circle: BézierShapeConvertible {
    public func bézierShape() -> BézierShape {
        
        let frame = self.frame
        let bézierCircularArcControlPointOffset = radius * .bézierCircularArcMultiplier
        
        return BézierShape
            .startBuilding()
            .move(to: frame.midXmaxY)
            
            // Someday, maybe this instaed:
//            .addArc(center: center, radius: radius, startAngle: .degrees(0), endAngle: .degrees(360))
            
            
            // Top-right arc ╮
            .addBézierCurve(to: frame.maxXmidY,
                            controlOffset1: CanvasPoint(x: center.x + bézierCircularArcControlPointOffset,
                                                        y: center.y + radius),
                            controlOffset2: CanvasPoint(x: center.x + radius,
                                                        y: center.y + bézierCircularArcControlPointOffset)
            )
            
            // Bottom-right arc ╯
            .addBézierCurve(to: frame.midXminY,
                            controlOffset1: CanvasPoint(x: center.x + radius,
                                                        y: center.y - bézierCircularArcControlPointOffset),
                            controlOffset2: CanvasPoint(x: center.x + bézierCircularArcControlPointOffset,
                                                        y: center.y - radius)
            )
            // Bottom-left arc ╰
            .addBézierCurve(to: frame.minXmidY,
                            controlOffset1: CanvasPoint(x: center.x - bézierCircularArcControlPointOffset,
                                                        y: center.y - radius),
                            controlOffset2: CanvasPoint(x: center.x - radius,
                                                        y: center.y - bézierCircularArcControlPointOffset)
            )
            // Top-left arc ╭
            .addBézierCurve(to: frame.midXmaxY,
                            controlOffset1: CanvasPoint(x: center.x - radius,
                                                        y: center.y + bézierCircularArcControlPointOffset),
                            controlOffset2: CanvasPoint(x: center.x - bézierCircularArcControlPointOffset,
                                                        y: center.y + radius)
            )
            .close()
            .doneBuilding()
    }
    
    
    var frame: CanvasRect {
        let diameter = self.diameter
        
        return CanvasRect(
            x: center.x - radius,
            y: center.y - radius,
            width: diameter,
            height: diameter)
    }
    
    
    var diameter: CGFloat { radius * 2 }
}
