//
//  Rectangle + Drawable.swift
//  
//
//  Created by Ben Leggiero on 2020-02-21.
//

import Foundation



extension Rectangle: BézierShapeConvertible {
    public func bézierShape() -> BézierShape {
        return BézierShape
            .startDrawing()
            .move(to: coordinates.minXminY)
            .line(to: coordinates.maxXminY)
            .line(to: coordinates.maxXmaxY)
            .line(to: coordinates.minXmaxY)
            .close()
            .doneDrawing()
    }
}
