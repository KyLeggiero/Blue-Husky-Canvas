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
        return BézierShape
            .startDrawing()
            .addArc(center: center, radius: radius, startAngle: .degrees(0), endAngle: .degrees(360))
            .close()
            .doneDrawing()
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
