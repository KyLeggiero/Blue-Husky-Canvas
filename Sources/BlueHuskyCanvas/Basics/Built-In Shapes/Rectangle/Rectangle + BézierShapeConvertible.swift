//
//  Rectangle + Drawable.swift
//  
//
//  Created by Ben Leggiero on 2020-02-21.
//

import Foundation



extension Rectangle: BézierShapeConvertible {
    public func bézierShape(at location: CanvasPoint) -> BézierShape {
        let rect = CanvasRect(origin: location,
                              size: size)
        
        return BézierShape.build {
            $0
                .move(to: rect.minXminY)
                .line(to: rect.maxXminY)
                .line(to: rect.maxXmaxY)
                .line(to: rect.minXmaxY)
                .close()
        }
    }
}
