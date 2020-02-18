//
//  Canvas Style.swift
//  
//
//  Created by Ben Leggiero on 2020-02-16.
//

import Foundation
import CrossKitTypes



public extension Canvas {
    struct Style {
        var background: Background
    }
}



public extension Canvas.Style {
    enum Background {
        case solid(color: NativeColor)
        case grid(Grid)
        case custom(drawable: Drawable)
    }
}
