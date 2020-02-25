//
//  Circle.swift
//  
//
//  Created by Ben Leggiero on 2020-02-21.
//

import Foundation



/// Represents a circle
public struct Circle {
    
    /// The location of the circle's center
    public var center: CanvasPoint
    
    /// The radius of the circle
    public var radius: CGFloat
    
    
    public init(
        center: CanvasPoint,
        radius: CGFloat
    ) {
        self.center = center
        self.radius = radius
    }
}
