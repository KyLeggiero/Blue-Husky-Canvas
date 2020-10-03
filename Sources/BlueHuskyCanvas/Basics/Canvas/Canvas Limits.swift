//
//  Canvas Limits.swift
//  Blue Husky Canvas
//
//  Created by Ben Leggiero on 2020-02-16.
//  Copyright © 2020 Ben Leggiero BH-1-PS
//

import Foundation
import RectangleTools



public extension Canvas {
    struct Limits {
        public var minX: Limit
        public var minY: Limit
        public var maxX: Limit
        public var maxY: Limit
        
        
        public init(minX: Limit = .infinite,
                    minY: Limit = .infinite,
                    maxX: Limit = .infinite,
                    maxY: Limit = .infinite)
        {
            self.minX = minX
            self.minY = minY
            self.maxX = maxX
            self.maxY = maxY
        }
    }
}



public extension Canvas.Limits {
    
    init(rectangle: CanvasRect) {
        self.init(
            minX: .offset(pointsFromZero: rectangle.minX),
            minY: .offset(pointsFromZero: rectangle.minY),
            maxX: .offset(pointsFromZero: rectangle.maxX),
            maxY: .offset(pointsFromZero: rectangle.maxY)
        )
    }
    
    
    init(origin: CanvasPoint = .zero,
                size: CanvasSize) {
        self.init(rectangle: CanvasRect(origin: origin, size: size))
    }
    
    
    static let infinite = Self(minX: .infinite, minY: .infinite, maxX: .infinite, maxY: .infinite)
}



public extension Canvas {
    enum Limit {
        case offset(pointsFromZero: Length)
        case infinite
        
        
        
        public typealias Length = CGFloat
    }
}



extension Canvas.Limit: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Length.FloatLiteralType) {
        self = .offset(pointsFromZero: Length(floatLiteral: value))
    }
}



extension Canvas.Limit: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Length.IntegerLiteralType) {
        self = .offset(pointsFromZero: Length(integerLiteral: value))
    }
}
